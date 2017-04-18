#!/bin/bash
set -ex

git clone --recursive https://github.com/leosinclairjr/ceph --branch wip_dmclock_clients --single-branch ceph

cd ceph

docker pull cephbuilder/ceph:kraken

source <(wget -qO- https://raw.githubusercontent.com/systemslab/docker-cephdev/master/aliases.sh)

dmake \
  -e BUILD_THREADS=`grep processor /proc/cpuinfo | wc -l` \
  -e CONFIGURE_FLAGS="-DWITH_TESTS=OFF -DCMAKE_BUILD_TYPE=Release" \
  -e RECONFIGURE="true" \
  -e CLEAN="true" \
  -e BASE_DAEMON_IMAGE="ceph/daemon:tag-build-master-kraken-ubuntu-16.04" \
  cephbuilder/ceph:kraken build-cmake
