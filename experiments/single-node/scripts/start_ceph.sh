#!/bin/bash
set -ex

cp ceph.conf /etc/ceph/ceph_extra.conf

./singlenode &

sleep 120

# TODO ensure that ceph is up and running OK

exit 1
