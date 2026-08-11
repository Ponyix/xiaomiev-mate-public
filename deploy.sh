#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
COMPOSE_FILE="${SCRIPT_DIR}/docker-compose.yml"
POSTGRES_CONTAINER="xiaomiev-postgres"
BACKEND_CONTAINER="xiaomiev-mate"
WEB_CONTAINER="xiaomiev-mate-web"
ENV_FILE="${SCRIPT_DIR}/.env"
ENV_EXAMPLE="${SCRIPT_DIR}/.env.example"
CONFIG_DIR="${SCRIPT_DIR}/config"
BACKUP_DIR="${CONFIG_DIR}/backup"
LOG_DIR="${SCRIPT_DIR}/logs"

if ! command -v docker >/dev/null 2>&1; then
  echo "未检测到 Docker，请先安装 Docker。"
  exit 1
fi

if docker compose version >/dev/null 2>&1; then
  COMPOSE_CMD=(docker compose)
elif command -v docker-compose >/dev/null 2>&1; then
  COMPOSE_CMD=(docker-compose)
else
  echo "未检测到 docker compose，请先安装 Docker Compose。"
  exit 1
fi

if [[ ! -f "${COMPOSE_FILE}" ]]; then
  echo "未找到 docker-compose 文件: ${COMPOSE_FILE}"
  exit 1
fi

if [[ ! -f "${ENV_FILE}" && -f "${ENV_EXAMPLE}" ]]; then
  echo "未检测到 .env，将使用 docker-compose.yml 中的默认数据库密码。"
  echo "建议先执行：cp .env.example .env 并修改 DB_PASSWORD。"
fi

if [[ -f "${ENV_FILE}" ]]; then
  set -a
  source "${ENV_FILE}"
  set +a
fi

BACKEND_IMAGE_TAG="${BACKEND_IMAGE_TAG:-latest}"
WEB_IMAGE_TAG="${WEB_IMAGE_TAG:-latest}"

mkdir -p "${LOG_DIR}" "${CONFIG_DIR}" "${BACKUP_DIR}"

echo "==> 当前部署镜像版本"
echo "后端镜像: ponyix/xiaomiev-mate:backend-${BACKEND_IMAGE_TAG}"
echo "前端镜像: ponyix/xiaomiev-mate:web-${WEB_IMAGE_TAG}"

echo "==> 启动服务"
"${COMPOSE_CMD[@]}" -f "${COMPOSE_FILE}" up -d

echo "==> 等待 PostgreSQL 就绪"
for i in {1..30}; do
  if docker inspect -f '{{.State.Health.Status}}' "${POSTGRES_CONTAINER}" 2>/dev/null | grep -q "healthy"; then
    break
  fi
  sleep 2
done

if ! docker inspect -f '{{.State.Health.Status}}' "${POSTGRES_CONTAINER}" 2>/dev/null | grep -q "healthy"; then
  echo "PostgreSQL 未就绪，请检查容器状态。"
  exit 1
fi

echo "==> 等待后端服务启动"
for i in {1..30}; do
  BACKEND_STATUS=$(docker inspect -f '{{.State.Status}}' "${BACKEND_CONTAINER}" 2>/dev/null || true)
  if [[ "${BACKEND_STATUS}" == "running" ]]; then
    break
  fi
  if [[ "${BACKEND_STATUS}" == "exited" || "${BACKEND_STATUS}" == "dead" ]]; then
    echo "后端服务启动失败，请查看日志："
    echo "${COMPOSE_CMD[*]} -f ${COMPOSE_FILE} logs ${BACKEND_CONTAINER}"
    exit 1
  fi
  sleep 2
done

if [[ "$(docker inspect -f '{{.State.Status}}' "${BACKEND_CONTAINER}" 2>/dev/null || true)" != "running" ]]; then
  echo "后端服务未正常运行，请查看日志："
  echo "${COMPOSE_CMD[*]} -f ${COMPOSE_FILE} logs ${BACKEND_CONTAINER}"
  exit 1
fi

if [[ "$(docker inspect -f '{{.State.Status}}' "${WEB_CONTAINER}" 2>/dev/null || true)" != "running" ]]; then
  echo "前端服务未正常运行，请查看日志："
  echo "${COMPOSE_CMD[*]} -f ${COMPOSE_FILE} logs ${WEB_CONTAINER}"
  exit 1
fi

echo "==> 部署完成"
echo "==> 前端访问地址: http://localhost:18080"
echo "==> 默认账号密码: admin"
echo "==> 加密密钥目录: ${CONFIG_DIR}/.secrets（请与数据库分开备份）"
echo "==> 自动备份目录: ${BACKUP_DIR}"
echo "如果是首次部署,登陆后请立即修改密码"
