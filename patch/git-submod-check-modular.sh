#!/bin/bash

cd `dirname ${0}`
patchdir=`pwd`
cd ..
rootdir=`pwd`
cd "${patchdir}"

while true ; do
    if read -r l_name ; then
        read -r l_path
        read -r l_url
        read -r l_frs
        read -r l_branch
        [[ $l_name =~ submodule..([a-z_0-9]+) ]]
        l_name=${BASH_REMATCH[1]}
        [[ $l_path =~ path...(.*) ]]
        l_path=${BASH_REMATCH[1]}
        [[ $l_url =~ url...(.*) ]]
        l_url=${BASH_REMATCH[1]}
        cd "${rootdir}/${l_path}"
        if [[ ! -e build.jam ]] ; then
            echo "===== ${l_name} -- ${l_url} -- ${l_path} <== NOT MODULAR"
        fi
    else
        break
    fi
done < "${rootdir}/.gitmodules"

cd "${rootdir}"
