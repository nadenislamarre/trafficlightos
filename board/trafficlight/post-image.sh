#!/bin/bash

mkdir -p "${BINARIES_DIR}/trafficlight" || exit 0
cp "${BINARIES_DIR}/"*".dtb"            "${BINARIES_DIR}/trafficlight/" || exit 1
cp "${BINARIES_DIR}/initrd.gz"          "${BINARIES_DIR}/trafficlight/" || exit 1
cp "${BINARIES_DIR}/rootfs.squashfs"    "${BINARIES_DIR}/trafficlight/" || exit 1
cp "${BINARIES_DIR}/zImage"             "${BINARIES_DIR}/trafficlight/" || exit 1
cp -pr "${BINARIES_DIR}/rpi-firmware/"* "${BINARIES_DIR}/trafficlight/" || exit 1
cp "board/trafficlight/cmdline.txt"     "${BINARIES_DIR}/trafficlight/" || exit 1
cp "board/trafficlight/config.txt"      "${BINARIES_DIR}/trafficlight/" || exit 1
