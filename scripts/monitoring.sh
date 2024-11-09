#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# go to project root
cd "$(dirname "$(realpath "$0")")/.."

docker rm -f grafana prometheus 1> /dev/null 2> /dev/null

echo >&2 "starting prometheus"
docker run -d --rm \
    --name "prometheus" \
    --network host \
    -p "127.0.0.1:9090:9090" \
    -v "${PWD}/monitoring/prometheus.yaml:/etc/prometheus/prometheus.yml:ro" \
    "prom/prometheus:latest"

echo >&2 "starting grafana"
docker run -d --rm \
    --name "grafana" \
    --env-file='./monitoring/grafana/config.env' \
    --network host \
    -p "127.0.0.1:3000:3000" \
    -v "${PWD}/monitoring/grafana/provisioning:/etc/grafana/provisioning" \
    "grafana/grafana:latest"

source './monitoring/grafana/config.env'

echo >&2 "user: ${GF_SECURITY_ADMIN_USER}"
echo >&2 "pass: ${GF_SECURITY_ADMIN_PASSWORD}"
echo >&2 "addr: http://127.0.0.1:3000/"
