#!/usr/bin/env bash

set -euo pipefail

# # /opt/p2-network/run/doppler-token-nyx should exist and contain a Doppler token
# [ -f /opt/p2-network/run/doppler-token-nyx ] || (echo "Doppler token does not exist" && exit 1)
# DOPPLER_TOKEN=$(cat /opt/p2-network/run/doppler-token-nyx)

# # /opt/p2-network/run should be created with appropriate permissions
# [ -d /opt/p2-network/run ] || (echo "/opt/p2-network/run does not exist" && exit 1)

# DOCKER_HEDGEDOC_DB_USER=hedgedoc
# DOCKER_HEDGEDOC_DB_PASSWORD=$(doppler secrets get DOCKER_HEDGEDOC_DB_PASSWORD --token "${DOPPLER_TOKEN}" --plain)
# DOCKER_HEDGEDOC_DB=hedgedoc

# echo "POSTGRES_USER=${DOCKER_HEDGEDOC_DB_USER}" > database.env
# echo "POSTGRES_PASSWORD=${DOCKER_HEDGEDOC_DB_PASSWORD}" >> database.env
# echo "POSTGRES_DB=${DOCKER_HEDGEDOC_DB}" >> database.env

# echo "PUID=$(id -u)" > hedgedoc.env
# echo "PGID=$(id -g)" >> hedgedoc.env
# echo "CMD_DB_URL=postgres://${DOCKER_HEDGEDOC_DB_USER}:${DOCKER_HEDGEDOC_DB_PASSWORD}@database:5432/${DOCKER_HEDGEDOC_DB}" >> hedgedoc.env

docker compose down