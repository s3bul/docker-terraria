#!/usr/bin/env bash
set -e

initServer() {
  cp -n "${SERVER_HOME}"/serverconfig.txt "${CONF_HOME}"/
  touch "${SERVER_HOME}"/.server-inited
}

runServer() {
  if [ ! -x "${SERVER_HOME}"/.server-inited ]; then
    initServer
  fi

  parameters="-config ${CONF_HOME}/serverconfig.txt"

  eval "${SERVER_HOME}/start-tModLoaderServer.sh ${parameters} $*"
}

firstCommand=${1}

case "${firstCommand}" in
run)
  shift
  runServer "$@"
  exit $?
  ;;
esac

exec "$@"
