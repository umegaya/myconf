#!/bin/sh

# install required package


## create work dir
mkdir tmp
cd tmp

## install git
yum install -y git

## install haskell

### install dependency via yum
yum install -y gmp-devel.x86_64
yum install -y zlib-devel.x86_64
yum install -y mesa-libGL-devel.x86_64
yum install -y mesa-libGLU-devel.x86_64
yum install -y freeglut-devel.x86_64

### download & copy haskell package to tmp
curl http://www.haskell.org/ghc/dist/7.4.2/ghc-7.4.2-i386-unknown-linux.tar.bz2>ghc.tar.bz2
tar -jxvf ghc.tar.bz2
curl http://lambda.haskell.org/platform/download/2012.4.0.0/haskell-platform-2012.4.0.0.tar.gz>haskell-platform.tar.gz
tar -zxvf haskell-platform.tar.gz

### install haskell platform
cd ghc-7.4.2
./configure
./install-sh
cd ../haskell-platform-2012.4.0.0
./configure
make
make install

## install pandoc
cabal update
cabal install pandoc


## install luajit & luarocks
cd .. # tmp
curl http://luajit.org/download/LuaJIT-2.0.0.tar.gz>luajit.tar.gz
tar -zxvf luajit.tar.gz
cd LuaJIT-2.0.0
make
make install
cd .. 
curl http://luarocks.org/releases/luarocks-2.0.12.tar.gz>luarocks.tar.gz
tar -zxvf luarocks.tar.gz
cd luarocks-2.0.12
./configure --with-lua-include=/usr/local/include/luajit-2.0/lua
make
make install

# ld.so.conf.d
cp ldconfig/luajit-x86_64.conf /etc/ld.so.conf.d/
cp ldconfig/yue.conf /etc/ld.so.conf.d/

/sbin/ldconfig


