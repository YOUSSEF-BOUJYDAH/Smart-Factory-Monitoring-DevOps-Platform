#!/bin/bash
source scripts/utils.sh

log "Stopping containers..."
docker rm -f smart-factory-api smart-factory-sensor || true

log "Removing network..."
docker network rm smart-factory-net || true

log "Cleanup done 🧹"