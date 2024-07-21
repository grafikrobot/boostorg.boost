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
            l_upstream=`git remote get-url --push upstream`
            l_repo=${l_upstream#https://github.com/boostorg/}
            l_repo=${l_repo/.git/}
            echo "gh pr list --repo=boostorg/${l_repo} --head=modular --json=number | grep -E \"([0-9]+)\" -o"
            l_pr=`gh pr list --repo=boostorg/${l_repo} --head=modular --json=number | grep -E "([0-9]+)" -o`
            echo "..... ${l_upstream} -- ${l_repo} -- ${l_pr}"
            sleep 1
            if test -z "${l_pr}" ; then
                echo gh pr create -b develop -d -F "${patchdir}/mod-pr-${1}.md" -t "Add support for modular build structure."
                sleep 1
                gh pr create -b develop -d -F "${patchdir}/mod-pr-${1}.md" -t "Add support for modular build structure."
                sleep 1
            fi
        fi
    else
        break
    fi
done < "${rootdir}/.gitmodules"

cd "${rootdir}"
echo "*****" `pwd`
