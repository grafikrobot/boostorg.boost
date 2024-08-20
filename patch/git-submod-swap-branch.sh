#!/bin/bash

cd `dirname ${0}`
patchdir=`pwd`
cd ..
rootdir=`pwd`
cd "${patchdir}"
echo "*****" `pwd`

cd "${rootdir}/${1}"
echo git status -s -b
git status -s -b
b=`git branch --show-current`
echo "Current: ${b}"
n=modular
if [[ "${b}" == "modular" ]] ; then
    n=develop
fi
echo "Switch To: ${n}"
echo git switch --no-guess "${n}"
git switch --no-guess "${n}"

cd "${rootdir}"
echo "*****" `pwd`
