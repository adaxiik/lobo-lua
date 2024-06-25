#!/bin/sh

PLATFORM=$1

CC=gcc

if [ "$PLATFORM" = "linux" ]; then
    CC=gcc
elif [ "$PLATFORM" = "mingw" ]; then
    CC=x86_64-w64-mingw32-gcc-posix
else
    echo "Invalid target"
    exit 1
fi

PROJECT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SRC_DIR=$PROJECT_PATH/src

INCLUDE_DIR=$SRC_DIR/include/lua

PLATFORM_FLAGS=""
if [ "$PLATFORM" = "linux" ]; then
    PLATFORM_FLAGS="-DLUA_USE_POSIX"
elif [ "$PLATFORM" = "mingw" ]; then
    PLATFORM_FLAGS="-DLUA_USE_WINDOWS"
fi

CFLAGS="-Wall -Wextra -Werror -std=c99 -O3 -ftree-vectorize -DMAKE_LIB -fno-stack-protector -fno-common"
OUTPUT_DIR=$PROJECT_PATH/$PLATFORM

mkdir -p $OUTPUT_DIR

$CC -c $CFLAGS $SRC_DIR/onelua.c -I$INCLUDE_DIR -o $OUTPUT_DIR/onelua.o
ar rcs $OUTPUT_DIR/liblua.a $OUTPUT_DIR/onelua.o
