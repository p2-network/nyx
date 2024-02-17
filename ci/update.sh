#!/usr/bin/env bash

set -euo pipefail

echo "Updating the CI environment..."

# For each directory in projects, run the update script
for dir in projects/*; do
  if [ -d "$dir" ]; then
    echo "Updating $dir..."
    # if a file called before.sh exists in the directory, run it
    [ -f "$dir/before.sh" ] && (cd "$dir" && ./before.sh)
    # if a docker-compose.yml file exists, run docker-compose up -d
    [ -f "$dir/docker-compose.yml" ] && (cd "$dir" && docker-compose up -d)
  fi
done