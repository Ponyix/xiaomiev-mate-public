#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
COMPOSE_FILE="${SCRIPT_DIR}/docker-compose.yml"
INIT_SQL="${SCRIPT_DIR}/initdb/01_init.sql"
POSTGRES_CONTAINER="xiaomiev-postgres"
ENV_FILE="${SCRIPT_DIR}/.env"
ENV_EXAMPLE="${SCRIPT_DIR}/.env.example"
BACKEND_IMAGE_TAG="${BACKEND_IMAGE_TAG:-latest}"
WEB_IMAGE_TAG="${WEB_IMAGE_TAG:-latest}"

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

if [[ ! -f "${INIT_SQL}" ]]; then
  echo "未找到初始化 SQL: ${INIT_SQL}"
  echo "请将 SQL 放置到 initdb/01_init.sql 后再执行。"
  exit 1
fi

if [[ ! -f "${ENV_FILE}" && -f "${ENV_EXAMPLE}" ]]; then
  echo "未检测到 .env，将使用默认数据库密码（you_password）。"
  echo "建议先执行：cp .env.example .env 并修改 DB_PASSWORD。"
fi

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

echo "==> 检查是否已初始化"
TABLE_EXISTS=$(docker exec -i "${POSTGRES_CONTAINER}" psql -U postgres -d xiaomi_ev -tAc "select 1 from information_schema.tables where table_name='sys_user' limit 1;")

if [[ "${TABLE_EXISTS}" == "1" ]]; then
  echo "数据库已初始化，跳过 SQL 执行。"
  exit 0
fi

echo "==> 执行初始化 SQL"
docker exec -i "${POSTGRES_CONTAINER}" psql -U postgres -d xiaomi_ev < "${INIT_SQL}"
echo "==> 初始化完成"
