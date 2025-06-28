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
        echo "===== ${l_name} -- ${l_url} -- ${l_path}"
        cd "${rootdir}/${l_path}"
        b=`git branch --show-current`
        echo "Current Branch: ${b}"
        n=develop
        if [[ "${b}" == "develop" ]] ; then
            n=master
        fi
        if [[ "${b}" != "modular" ]] ; then
            echo git status -s -b
            git status -s -b
            echo "Switch To: ${n}"
            echo git switch --no-guess "${n}"
            git switch --no-guess "${n}"
            if [[ $? -ne 0 ]] ; then
                echo git checkout --no-guess -B ${n} --track=origin/${n}
                git checkout --no-guess -B ${n} --track=origin/${n}
            fi
       fi
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
