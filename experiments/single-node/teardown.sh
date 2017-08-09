#!/bin/bash
set -ex
docker stop cephd || true
docker rm cephd || true
