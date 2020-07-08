#!/bin/bash
set -euo pipefail # exit immediately when a command fails

DOCKERFILE=$1
CONTEXT=$2
DOCKER_IMAGE=$3
DOCKER_IMAGE_TAG=$4
DOCKER_REGISTRY_HOST=$5
DOCKER_REGISTRY_USERNAME=$6
DOCKER_REGISTRY_PASSWORD=$7


DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG/refs\/heads\/}
DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG/refs\/tags\/}
if [[ "$DOCKER_IMAGE_TAG" = "master" ]]; then
	DOCKER_IMAGE_TAG="latest"
fi

docker login $DOCKER_REGISTRY_HOST -u $DOCKER_REGISTRY_USERNAME -p $DOCKER_REGISTRY_PASSWORD
docker build -f $DOCKERFILE -t $DOCKER_REGISTRY_HOST/$DOCKER_IMAGE:$DOCKER_IMAGE_TAG $CONTEXT
docker push $DOCKER_REGISTRY_HOST/$DOCKER_IMAGE:$DOCKER_IMAGE_TAG
