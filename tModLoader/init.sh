#!/usr/bin/env bash

if [ -f ./.server-init ]; then
  echo Server started
  exit 1
fi

docker compose run server --create &&
  (docker swarm init 2>/dev/null || echo "swarm") &&
  (cd ./server &&
    cp swarm-dist.yml swarm.yml &&
    docker stack deploy -c swarm.yml terraria) &&
  touch ./.server-init
