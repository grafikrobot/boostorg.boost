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
		if ! gh repo view grafikrobot/boostorg.${l_name} --json=description 2>&1 >/dev/null ; then
			echo gh repo fork boostorg/${l_name} --fork-name boostorg.${l_name} --remote --remote-name grafikrobot.boostorg.${l_name} --clone=false
			gh repo fork boostorg/${l_name} --fork-name boostorg.${l_name} --remote --remote-name grafikrobot.boostorg.${l_name} --clone=false
		fi
		echo gh repo edit grafikrobot/boostorg.${l_name} --default-branch=develop
		gh repo edit grafikrobot/boostorg.${l_name} --default-branch=develop
	else
		break
	fi
done < "${rootdir}/.gitmodules"

cd "${rootdir}"
echo "*****" `pwd`
