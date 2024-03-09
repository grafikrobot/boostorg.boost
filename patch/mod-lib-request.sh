#!/bin/bash

set -e

cd `dirname ${0}`
cd ..
rootdir=`pwd`
patchdir=${rootdir}/../modular/patch
echo "*****" `pwd`

# accumulators \
# algorithm \
# array \
# asio \
# assert \
# assign \
# bimap \
# bind \
# callable_traits \
# charconv \
# chrono \
# cobalt \
# compatibility \
# compute \
# concept_check \
# container \
# container_hash \
# context \
# contract \
# coroutine \
# coroutine2 \
# describe \
# endian \
# exception \
# fiber \
# foreach \
# format \
# function \
# function_types \
# graph \
# graph_parallel \
# heap \
# histogram \
# hof \
# icl \
# interprocess \
# interval \
# intrusive \
# lambda \
# lambda2 \
# leaf \
# local_function \
# lockfree \
# logic \
# move \
# mp11 \
# mpi \
# mpl \
# pool \
# process \
# property_map \
# property_map_parallel \
# property_tree \
# proto \
# ptr_container \
# qvm \
# ratio \
# rational \
# redis \
# safe_numerics \
# scope_exit \
# serialization \
# signals2 \
# statechart \
# system \
# thread \
# throw_exception \
# timer \
# tokenizer \
# tti \
# type_erasure \
# typeof \
# ublas \
# units \
# variant2 \
# vmd \
# xpressive\

repos="\
"

for repo in ${repos}
do
	echo "===== ${repo}"
	echo gh issue create --body-file "${rootdir}/patch/mod-lib-request.md" --title "Modular Boost C++ Libraries Request" --repo "boostorg/${repo}"
	sleep 5
	gh issue create --body-file "${rootdir}/patch/mod-lib-request.md" --title "Modular Boost C++ Libraries Request" --repo "boostorg/${repo}"
done

cd "${rootdir}"
echo "*****" `pwd`
