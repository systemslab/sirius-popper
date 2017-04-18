#!/bin/bash
set -ex

source <(wget -qO- https://raw.githubusercontent.com/systemslab/docker-cephdev/master/aliases.sh)

docker pull cephbuilder/ceph:kraken

dmake \
  -e SHA1_OR_REF="wip_dmclock_clients" \
  -e GIT_URL="https://github.com/leosinclairjr/ceph.git" \
  -e BUILD_THREADS=`grep processor /proc/cpuinfo | wc -l` \
  -e CONFIGURE_FLAGS="-DWITH_TESTS=OFF" \
  -e RECONFIGURE="true" \
  -e CLEAN="true" \
  -e BASE_DAEMON_IMAGE="ceph/daemon:tag-build-master-kraken-ubuntu-16.04" \
  cephbuilder/ceph:kraken build-cmake
