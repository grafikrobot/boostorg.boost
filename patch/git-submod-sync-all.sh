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
		echo gh repo sync grafikrobot/boostorg.${l_name} --branch develop --source boostorg/${l_name}
		gh repo sync grafikrobot/boostorg.${l_name} --branch develop --source boostorg/${l_name}
		cd "${rootdir}/${l_path}"
		echo git status -s -b
		git status -s -b
		echo git remote add -t develop upstream https://github.com/boostorg/${l_name}.git
		git remote add -t develop upstream https://github.com/boostorg/${l_name}.git
		echo git fetch -p upstream
		git fetch -p upstream
		echo git checkout modular
		git checkout modular
		echo git pull modular
		git pull modular
		echo git merge upstream/develop -m "Sync from upstream."
		git merge upstream/develop -m "Sync from upstream."
		echo git status -s -b
		git status -s -b
	else
		break
	fi
done < "${rootdir}/.gitmodules"

echo "===== boost -- upstream"
cd "${rootdir}"
echo git fetch -p upstream
git fetch -p upstream
echo git merge upstream/develop -m "Sync from upstream."
git merge upstream/develop -m "Sync from upstream."

cd "${rootdir}"
echo "*****" `pwd`
