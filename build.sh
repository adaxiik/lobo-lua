#!/bin/sh

CC=g++

if [ ! -z "$1" ]; then
    CC=$1
fi


PROJECT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SRC_DIR=$PROJECT_PATH/src

INCLUDE_DIR=$SRC_DIR/include/lua
CFLAGS="-Wall -Wextra -Werror -std=c++17 -O3 -ftree-vectorize -flto -DMAKE_LIB -fno-stack-protector -fno-common"
OUTPUT_DIR=$PROJECT_PATH/linux
if [ ! -z "$2" ]; then
    OUTPUT_DIR=$PROJECT_PATH/$2
fi

mkdir -p $OUTPUT_DIR

$CC -c $CFLAGS $SRC_DIR/onelua.c -I$INCLUDE_DIR -o $OUTPUT_DIR/onelua.o
ar rcs $OUTPUT_DIR/liblua.a $OUTPUT_DIR/onelua.o
