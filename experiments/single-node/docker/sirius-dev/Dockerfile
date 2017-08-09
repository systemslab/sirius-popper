FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
      cmake g++ librados-dev libprotobuf-dev protobuf-compiler git \
      libboost-dev libboost-system-dev libboost-program-options-dev \
      libatomic-ops-dev liblmdb-dev openmpi-bin libopenmpi-dev ceph-common && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    git clone --recursive https://github.com/noahdesu/zlog /src/zlog && \
    cd /src/zlog && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j `nproc` && \
    make install && \
    cd / && \
    rm -r /src/zlog
