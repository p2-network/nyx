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

    # if a file called before.sh exists in the directory, run it
    [ -f "$dir/before.sh" ] && (cd "$dir" && ./before.sh)
    # if a docker-compose.yml file exists, run docker-compose up -d
    [ -f "$dir/docker-compose.yml" ] && (cd "$dir" && docker compose up -d)

    echo "::endgroup::"

  fi
done
