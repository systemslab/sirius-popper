#!/bin/bash
set -e

docker run --rm \
  -e OS_AUTH_URL=$OS_AUTH_URL \
  -e OS_TENANT_ID=$OS_TENANT_ID \
  -e OS_TENANT_NAME=$OS_TENANT_NAME \
  -e OS_PROJECT_NAME=$OS_PROJECT_NAME \
  -e OS_USERNAME=$OS_USERNAME \
  -e OS_PASSWORD=$OS_PASSWORD \
  -e OS_KEYNAME=$OS_KEYNAME \
  -v `pwd`/enos:/enos \
  --workdir=/enos \
  ivotron/enos:2.3.0 destroy

exit 0
