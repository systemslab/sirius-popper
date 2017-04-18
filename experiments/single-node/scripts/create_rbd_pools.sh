#!/bin/bash

ceph osd getcrushmap -o /tmp/crush
crushtool -i /tmp/crush --set-chooseleaf_vary_r 0 -o /tmp/crush.new
ceph osd setcrushmap -i /tmp/crush.new
echo 3 | tee /proc/sys/vm/drop_caches && sync
ceph osd pool create jackpool 100 100
ceph osd pool create jillpool 100 100
ceph auth get-or-create client.jack mon 'allow r' osd 'allow * pool=jackpool' -o jackkeyring
ceph auth get-or-create client.jill mon 'allow r' osd 'allow * pool=jillpool' -o jillkeyring
wait
rbd create jackimage --size 20480 --image-feature layering --pool jackpool
rbd map jackimage --pool jackpool --name client.jack -k jackkeyring
/sbin/mkfs.ext4 -m0 /dev/rbd/jackpool/jackimage
mkdir /mnt/jack-block-device
mount /dev/rbd/jackpool/jackimage /mnt/jack-block-device
rbd create jillimage --size 20480 --image-feature layering --pool jillpool
rbd map jillimage --pool jillpool --name client.jill -k jillkeyring
/sbin/mkfs.ext4 -m0 /dev/rbd/jillpool/jillimage
mkdir /mnt/jill-block-device
mount /dev/rbd/jillpool/jillimage /mnt/jill-block-device


