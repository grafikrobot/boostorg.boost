#!/bin/bash

set -e

cd `dirname ${0}`
patchdir=`pwd`
cd ..
rootdir=`pwd`
echo "*****" `pwd`
subdir=${1}
submod=`basename ${subdir}`
echo git submodule update --init "${subdir}"
git submodule update --init "${subdir}"
cd "${subdir}"
echo "=====" `pwd`
if test `git remote show` == "origin" ; then
	echo git remote add grafikrobot.boostorg.${submod} https://github.com/grafikrobot/boostorg.${submod}.git
	git remote add grafikrobot.boostorg.${submod} https://github.com/grafikrobot/boostorg.${submod}.git
fi
echo git fetch -p --all
git fetch -p --all
# Create modular branch from develop.
if ! git ls-remote --exit-code --heads grafikrobot.boostorg.${submod} refs/heads/modular ; then
	echo git switch --no-guess --no-track -c modular grafikrobot.boostorg.${submod}/develop
	git switch --no-guess --no-track -c modular grafikrobot.boostorg.${submod}/develop
	echo git push --set-upstream grafikrobot.boostorg.${submod} modular:refs/heads/modular
	git push --set-upstream grafikrobot.boostorg.${submod} modular:refs/heads/modular
fi
echo git fetch -p --all
git fetch -p --all
cd "${rootdir}"
echo "*****" `pwd`
