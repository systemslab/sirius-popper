#!/bin/bash

./start_ceph.sh

./create_rbd_pools.sh

./run_fio.sh

./clean_rbd_pools.sh

exit 0
