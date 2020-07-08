#!/bin/bash
set -euo pipefail # exit immediately when a command fails

DOCKERFILE=$1
CONTEXT=$2

docker build -f $DOCKERFILE -t test:test $CONTEXT
