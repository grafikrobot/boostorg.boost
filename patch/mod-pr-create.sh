#!/bin/bash

cd `dirname ${0}`
patchdir=`pwd`
cd ..
rootdir=`pwd`
cd "${patchdir}"
echo "*****" `pwd`

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
        if [[ $l_path =~ ^(${1}).* ]] ; then
            echo "===== ${l_name} -- ${l_url} -- ${l_path}"
            cd "${rootdir}/${l_path}"
            echo git status -s -b
            git status -s -b
            sleep 3
            echo gh pr create -b develop -d -F "${patchdir}/mod-pr-${1}.md" -t "Add support for modular build structure."
            gh pr create -b develop -d -F "${patchdir}/mod-pr-${1}.md" -t "Add support for modular build structure."
        fi
    else
        break
    fi
done < "${rootdir}/.gitmodules"

cd "${rootdir}"
echo "*****" `pwd`
