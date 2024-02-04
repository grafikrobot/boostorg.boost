#!/bin/bash

set -e

cd `dirname ${0}`
cd ..
rootdir=`pwd`
patchdir=${rootdir}/../modular/patch
echo "*****" `pwd`

subdir=${1}
submod=`basename ${subdir}`
cd "${subdir}"
git reset --hard
git pull -r
if test "${2}" == "--diff" ; then
	if test -s "${patchdir}/${subdir}/patch.diff" ; then
		patch -uN -p1 "--input=${patchdir}/${subdir}/patch.diff"
	fi
fi
cd "${patchdir}/${subdir}"
find . -name build.jam -exec bash -c "cp {} ${rootdir}/${subdir}/{}" ";"
find . -name build.jam -exec bash -c "cd ${rootdir}/${subdir} && cd \`dirname {}\` && rm -f *amfile*" ";"

cd "${rootdir}"
echo "*****" `pwd`
