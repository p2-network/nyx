#!/usr/bin/env bash

set -euo pipefail

echo "Updating the CI environment..."

# get director of current script

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $BASE_DIR/..

PROJECTS_DIR=$( realpath "$BASE_DIR"/../projects )

echo "Looking for projects in $PROJECTS_DIR"

# Update all projects
for dir in $PROJECTS_DIR/*; do
  if [ -d "$dir" ]; then

    echo "::group::Updating $dir..."

    pushd $dir

    [ -f "$dir/before.sh" ] && (./before.sh)
    [ -f "$dir/docker-compose.yml" ] && (docker compose up -d)

    popd

    echo "::endgroup::"

  fi
done
