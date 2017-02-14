#!/usr/bin/env bash
################################################################################
#
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
#
################################################################################
#Breif:
#Authors: zhangfangjie(f22jay@gmail.com)
#Date:    2017/02/14 10:12:20
function log() {
    datestr=$(date "+%Y-%m-%d %H:%M")
    echo "$datestr [${BASH_SOURCE[1]}:${BASH_LINENO[0]}][${FUNCNAME[1]}] $1"
}
