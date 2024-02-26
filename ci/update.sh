#!/usr/bin/env bash

set -euo pipefail

echo "Updating the CI environment..."

# get director of current script

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $BASE_DIR/..

PROJECTS_DIR=$( realpath "$BASE_DIR"/../projects )

echo "Looking for projects in $PROJECTS_DIR"

# function that runs a command in a project directory
update_project() {
  local project=$1

    echo "::group::Updating $project..."

    [ -f "$project/before.sh" ] && (cd $project; ./before.sh)
    [ -f "$project/docker-compose.yml" ] && (cd $project; docker compose up -d)

    echo "::endgroup::"
}

# Special case for traefik - we want to run it first, and renaming it now is ... difficult
update_project $PROJECTS_DIR/traefik

# Then find all the rest, but only if they start with a number
for project in $PROJECTS_DIR/[0-9]*; do
  if [ -d "$project" ]; then
    update_project $project
  fi
done
