#!/bin/bash

set -e

cd `dirname ${0}`
patchdir=`pwd`
cd ..
rootdir=`pwd`
echo "*****" `pwd`
subdir=${1}
submod=`basename ${subdir}`
echo git submodule update --init --force "${subdir}"
git submodule update --init --force "${subdir}"
cd "${subdir}"
echo "=====" `pwd`
echo git remote add grafikrobot.boostorg.${submod} https://github.com/grafikrobot/boostorg.${submod}.git
git remote add grafikrobot.boostorg.${submod} https://github.com/grafikrobot/boostorg.${submod}.git
echo git fetch -p --all
git fetch -p --all
echo git switch -c modular grafikrobot.boostorg.${submod}/modular
git switch -c modular grafikrobot.boostorg.${submod}/modular
cd "${rootdir}"
echo "*****" `pwd`
