#!/usr/bin/env bash

USER_UID=$(id -u)

docker compose run server --create &&
  sudo chown -R "${USER_UID}:0" ./server/.docker &&
  docker swarm init &&
  (cd ./server &&
    cp swarm-dist.yml swarm.yml &&
    docker stack deploy -c swarm.yml terraria)
