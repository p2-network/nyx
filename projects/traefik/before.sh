#!/usr/bin/env bash

set -euo pipefail

# /opt/p2-network/run/doppler-token-nyx should exist and contain a Doppler token
[ -f /opt/p2-network/run/doppler-token-nyx ] || (echo "Doppler token does not exist" && exit 1)
DOPPLER_TOKEN=$(cat /opt/p2-network/run/doppler-token-nyx)

# /opt/p2-network/run should be created with appropriate permissions
[ -d /opt/p2-network/run ] || (echo "/opt/p2-network/run does not exist" && exit 1)

# I actually hate lego+traefik right now, THIS IS ABSOLUTELY STUPID.
DOCKER_TRAEFIK_AWS_SHARED_CREDENTIALS_FILE_AWS_ACCESS_KEY_ID=$(doppler secrets get DOCKER_TRAEFIK_ROUTE53_ACCESSKEY --token "${DOPPLER_TOKEN}" --plain)
DOCKER_TRAEFIK_AWS_SHARED_CREDENTIALS_FILE_AWS_SECRET_ACCESS_KEY=$(doppler secrets get DOCKER_TRAEFIK_ROUTE53_SECRET --token "${DOPPLER_TOKEN}" --plain)

echo "[default]" > /opt/p2-network/run/DOCKER_TRAEFIK_AWS_SHARED_CREDENTIALS_FILE
echo "aws_access_key_id=${DOCKER_TRAEFIK_AWS_SHARED_CREDENTIALS_FILE_AWS_ACCESS_KEY_ID}" >> /opt/p2-network/run/DOCKER_TRAEFIK_AWS_SHARED_CREDENTIALS_FILE
echo "aws_secret_access_key=${DOCKER_TRAEFIK_AWS_SHARED_CREDENTIALS_FILE_AWS_SECRET_ACCESS_KEY}" >> /opt/p2-network/run/DOCKER_TRAEFIK_AWS_SHARED_CREDENTIALS_FILE

# traefik
doppler secrets get DOCKER_TRAEFIK_CF_DNS_API_TOKEN --token "${DOPPLER_TOKEN}" --plain > /opt/p2-network/run/DOCKER_TRAEFIK_CF_DNS_API_TOKEN
doppler secrets get DOCKER_TRAEFIK_ACME_EMAIL  --token "${DOPPLER_TOKEN}" --plain > /opt/p2-network/run/DOCKER_TRAEFIK_ACME_EMAIL

# if /opt/p2-network/traefik-acme/ does not exist, create it
[ -d /opt/p2-network/traefik-acme ] || mkdir /opt/p2-network/traefik-acme
