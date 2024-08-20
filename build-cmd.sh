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

if [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]] ; then
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
    cp -a tinyexr.cc "$stage/include/tinyexr"
    cp -a tinyexr.h "$stage/include/tinyexr"
    mkdir -p "$stage/LICENSES"
    cp -a ../LICENSE.tinyexr "$stage/LICENSES/tinyexr_license.txt"
popd

