#!/usr/bin/env bash

if [ -f ./.server-init ]; then
  echo Server started
  exit 1
fi

USER_UID=${USER_UID:-$(id -u)}

chown -vR "${USER_UID}:0" ./server/.docker &&
  chmod -vR g+w ./server/.docker &&
  (docker compose run -u "${USER_UID}:0" server || echo "run-server") &&
  (docker swarm init 2>/dev/null || echo "swarm") &&
  (cd ./server &&
    cp -vn swarm-dist.yml swarm.yml) &&
  touch ./.server-init &&
  chown -v "${USER_UID}:0" ./.server-init ./server/swarm.yml
