#!/bin/bash
set -e

source scripts/utils.sh

NETWORK="smart-factory-net"

log "Creating Docker network..."
docker network create $NETWORK || true

log "Building Docker images..."
docker build -t smart-factory-api:local -f docker/api.Dockerfile .
docker build -t smart-factory-sensor:local -f docker/sensor.Dockerfile .

log "Starting API container..."
docker run -d \
  --name smart-factory-api \
  --network $NETWORK \
  -p 5000:5000 \
  smart-factory-api:local || true

log "Starting sensor container..."
docker run -d \
  --name smart-factory-sensor \
  --network $NETWORK \
  -e API_URL=http://smart-factory-api:5000/data \
  smart-factory-sensor:local || true

log "Deployment complete "