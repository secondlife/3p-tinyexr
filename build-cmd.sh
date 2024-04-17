#!/usr/bin/env bash

cd "$(dirname "$0")"

# turn on verbose debugging output for parabuild logs.
exec 4>&1; export BASH_XTRACEFD=4; set -x

# make errors fatal
set -e

# complain about unreferenced environment variables
set -u

if [ -z "$AUTOBUILD" ] ; then
    exit 1
fi

if [ "$OSTYPE" = "cygwin" ] ; then
    autobuild="$(cygpath -u $AUTOBUILD)"
else
    autobuild="$AUTOBUILD"
fi

top="$(pwd)"
stage="$top/stage"

# load autobuild provided shell functions and variables
tinyexr_SOURCE_DIR="tinyexr"

pushd "$tinyexr_SOURCE_DIR"
    mkdir -p "$stage/include/tinyexr"
    cp -a tiny_gltf.h "$stage/include/tinyexr"
    cp -a stb_image.h "$stage/include/tinyexr"
    cp -a stb_image_write.h "$stage/include/tinyexr"
    cp -a json.hpp "$stage/include/tinyexr"
    mkdir -p "$stage/LICENSES"
    cp -a LICENSE "$stage/LICENSES/tinyexr_license.txt"
    echo "v1.0.8" > "$stage/include/tinyexr/tinyexr_version.txt"
popd

