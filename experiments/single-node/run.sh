#!/bin/bash
set -ex

docker run --rm \
  -v `pwd`/scripts:/root/scripts \
  -v `pwd`/results:/results \
  --workdir=/root/scripts \
  --entrypoint=/bin/bash \
  --cap-add=SYS_ADMIN \
  --privileged \
  --device /dev/fuse \
  -v /dev:/dev \
  ivotron/ceph:dmclock \
    -c "/root/scripts/run_experiment.sh"
