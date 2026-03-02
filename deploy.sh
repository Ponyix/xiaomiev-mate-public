#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
COMPOSE_FILE="${SCRIPT_DIR}/docker-compose.yml"
INIT_SQL="${SCRIPT_DIR}/initdb/01_init.sql"
POSTGRES_CONTAINER="xiaomiev-postgres"

if [[ ! -f "${COMPOSE_FILE}" ]]; then
  echo "未找到 docker-compose 文件: ${COMPOSE_FILE}"
  exit 1
fi

if [[ ! -f "${INIT_SQL}" ]]; then
  echo "未找到初始化 SQL: ${INIT_SQL}"
  echo "请将 SQL 放置到 initdb/01_init.sql 后再执行。"
  exit 1
fi

echo "==> 启动服务"
docker compose -f "${COMPOSE_FILE}" up -d

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
