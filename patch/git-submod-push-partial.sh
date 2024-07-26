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
        case ${l_name} in
            core | geometry | locale | log | mysql | test | variant2 | winapi )
            echo "===== ${l_name} -- ${l_url} -- ${l_path}"
            cd "${rootdir}/${l_path}"
            echo "git push"
            git push
            ;;
        esac
    else
        break
    fi
done < "${rootdir}/.gitmodules"

echo "===== status"
cd "${rootdir}"
git submodule foreach git status -sb
git status -sb

cd "${rootdir}"
echo "*****" `pwd`
