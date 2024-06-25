#!/bin/sh

CC=g++

if [ ! -z "$1" ]; then
    CC=$1
fi

PROJECT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SRC_DIR=$PROJECT_PATH/src
INCLUDE_DIR=$SRC_DIR/include/lua
CFLAGS="-Wall -Wextra -Werror -std=c++17 -O3 -ftree-vectorize -flto -DMAKE_LIB -fno-stack-protector -fno-common"

$CC -c $CFLAGS $SRC_DIR/onelua.c -I$INCLUDE_DIR -o $PROJECT_PATH/onelua.o
ar rcs $PROJECT_PATH/liblua.a $PROJECT_PATH/onelua.o
