#!/bin/bash
source scripts/utils.sh

log "Checking API health..."
curl -s http://localhost:5000/health || error "API not reachable"

log "Checking metrics..."
curl -s http://localhost:5000/metrics | grep sensor_messages_total || error "Metrics not found"

log "All tests passed ✅"