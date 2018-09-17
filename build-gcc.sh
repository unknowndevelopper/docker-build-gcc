#!/usr/bin/env bash

set -e

# https://gcc.gnu.org/wiki/InstallingGCC

VERSION=8.2.0

#curl ftp://gcc.gnu.org/pub/gcc/releases/gcc-${VERSION}/gcc-${VERSION}.tar.gz | tar -xz
#curl -k https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.gz | tar -xz

mkdir gcc-${VERSION}-build
pushd gcc-${VERSION}-build

../gcc-${VERSION}/configure --prefix=/usr/local/gcc/gcc-${VERSION} --enable-languages=c,c++
make -j$(getconf _NPROCESSORS_ONLN)
make install

popd

cd /usr/local/gcc 
tar cvfz /standalone-gcc-${VERSION}.tar.gz gcc-${VERSION}


