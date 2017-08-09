#!/bin/bash
set -ex

CEPH_NET=175.20.0.0/16

netexists=`docker network ls --filter name=cephnet -q | wc -l`
if [ $netexists -eq 0 ]; then
  docker network create --subnet=$CEPH_NET cephnet
fi

docker pull ceph/demo:tag-build-master-kraken-ubuntu-16.04

MON_IP=175.20.0.12

docker run -d \
  --name=cephd \
  --net cephnet \
  --ip $MON_IP \
  -v `pwd`/etcceph:/etc/ceph \
  -e MON_IP=$MON_IP \
  -e CEPH_PUBLIC_NETWORK=$CEPH_NET \
  ceph/demo:tag-build-master-kraken-ubuntu-16.04
