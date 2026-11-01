#!/usr/bin/env bash
set -euo pipefail

IMAGE="trdl:e2e"
PORT="${PORT:-18080}"

docker build -q -t "$IMAGE" .
CID=$(docker run -d --rm -p "$PORT:8080" "$IMAGE")
trap 'docker stop "$CID" >/dev/null' EXIT

for _ in $(seq 1 30); do
  curl -fsS "http://localhost:$PORT/readyz" >/dev/null 2>&1 && break
  sleep 1
done

test "$(curl -fsS "http://localhost:$PORT/")" = "42"
test "$(curl -s -o /dev/null -w '%{http_code}' -X POST "http://localhost:$PORT/")" = "405"
test "$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:$PORT/nope")" = "404"

echo "E2E passed"
