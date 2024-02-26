#!/usr/bin/env bash

set -euo pipefail

# /opt/p2-network/run/doppler-token-nyx should exist and contain a Doppler token
[ -f /opt/p2-network/run/doppler-token-nyx ] || (echo "Doppler token does not exist" && exit 1)
DOPPLER_TOKEN=$(cat /opt/p2-network/run/doppler-token-nyx)

# /opt/p2-network/run should be created with appropriate permissions
[ -d /opt/p2-network/run ] || (echo "/opt/p2-network/run does not exist" && exit 1)

DOCKER_DAIKIN_EXPORTER_AC_IP=$(doppler secrets get DOCKER_DAIKIN_EXPORTER_AC_IP --token "${DOPPLER_TOKEN}" --plain)
DOCKER_DAIKIN_EXPORTER_AC_UUID=$(doppler secrets get DOCKER_DAIKIN_EXPORTER_AC_UUID --token "${DOPPLER_TOKEN}" --plain)

echo "AC_IP=${DOCKER_DAIKIN_EXPORTER_AC_IP}" > daikin-exporter.env
echo "AC_UUID=${DOCKER_DAIKIN_EXPORTER_AC_UUID}" >> daikin-exporter.env
