#!/bin/sh

# ld.so.conf.d
cp ldconfig/luajit-x86_64.conf /etc/ld.so.conf.d/
cp ldconfig/yue.conf /etc/ld.so.conf.d/

/sbin/ldconfig


