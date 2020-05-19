#!/bin/bash

set -Eeuox pipefail

STACK="quarkus"
APP="sample-quarkus" \
DOCKER_IMAGE="image-registry.openshift-image-registry.svc:5000/kabanero" \
APP_REPO="https://github.com/kabanero-io/${APP}/" \
PIPELINE_RUN="${APP}-build-deploy-pl-run-kabanero" \
PIPELINE_REF="${STACK}-build-deploy-pl" \
DOCKER_IMAGE_REF="${APP}-docker-image" \
GITHUB_SOURCE_REF="${APP}-git-source" \
$(dirname "$0")/pipelinerun.sh
