#!/bin/bash
set -ex

if [ -d ceph ] ; then
  sudo rm -rf ceph
fi

git clone \
  --recursive https://github.com/leosinclairjr/ceph \
  --branch wip_dmclock_clients \
  --single-branch \
  ceph

cd ceph

wget https://raw.githubusercontent.com/systemslab/docker-cephdev/e0e1ba42919388a64a695d2822d3e5f656c2d67b/aliases.sh
source aliases.sh
rm aliases.sh

docker pull cephbuilder/ceph:kraken

dmake \
  -e CONFIGURE_FLAGS="-DWITH_TESTS=OFF -DCMAKE_BUILD_TYPE=Release" \
  -e RECONFIGURE="true" \
  -e CLEAN="true" \
  -e BASE_DAEMON_IMAGE="ceph/daemon:tag-build-master-kraken-ubuntu-16.04" \
  cephbuilder/ceph:kraken build-cmake
