#!/bin/bash

set -e

cd `dirname ${0}`
cd ..
rootdir=`pwd`
echo "*****" `pwd`

echo "|"
echo "| Cleanup Boost"
echo "|"
rm -rf bin.v2 boost b2 .local *-config.jam*
echo "|"
echo "| Setup Boost"
echo "|"
./bootstrap.sh
./b2 -d0 headers
echo "|"
echo "| Build Boost"
echo "|"
./b2 stage
echo "|"
echo "| Install Boost"
echo "|"
./b2 --prefix=${rootdir}/.local install
echo "|"
echo "| Test Boost"
echo "|"
cd status
../b2 quick

cd "${rootdir}"
echo "*****" `pwd`
