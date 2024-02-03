#!/bin/bash

set -e

cd `dirname ${0}`
patchdir=`pwd`
cd ..
rootdir=`pwd`
echo "*****" `pwd`
subdir=${1}
submod=`basename ${subdir}`
git submodule init "${subdir}"
cd "${subdir}"
git remote add grafikrobot.boostorg.${submod} https://github.com/grafikrobot/boostorg.${submod}.git
git fetch
git switch -c modular grafikrobot.boostorg.${submod}/modular
cd "${rootdir}"
echo "*****" `pwd`
