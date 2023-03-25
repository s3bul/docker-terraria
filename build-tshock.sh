#!/usr/bin/env bash

source .env

BUILD_IMAGE_NAME=${IMAGE_TSHOCK_NAME}:${IMAGE_TSHOCK_VERSION}

(cd ./TShock &&
  git checkout v"${IMAGE_TSHOCK_VERSION}" &&
  git submodule update --init --remote --merge &&
  docker build -t "${BUILD_IMAGE_NAME}" --build-arg TARGETPLATFORM="${TARGETPLATFORM}" . &&
  docker push "${BUILD_IMAGE_NAME}")
