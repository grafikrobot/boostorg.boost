#!/bin/bash

cd `dirname ${0}`
patchdir=`pwd`
cd ..
rootdir=`pwd`
cd "${patchdir}"
echo "*****" `pwd`

project_id=PVT_kwHOAC2_7c4Aa9R9
# {
#   "fields": [
#     {
#       "id": "PVTF_lAHOAC2_7c4Aa9R9zgRUW80",
#       "name": "Title",
#       "type": "ProjectV2Field"
#     },
#     {
#       "id": "PVTF_lAHOAC2_7c4Aa9R9zgRUW84",
#       "name": "Assignees",
#       "type": "ProjectV2Field"
#     },
#     {
#       "id": "PVTSSF_lAHOAC2_7c4Aa9R9zgRUW88",
#       "name": "Status",
#       "options": [
#         {
#           "id": "f75ad846",
#           "name": "Todo"
#         },
#         {
#           "id": "47fc9ee4",
#           "name": "In Progress"
#         },
#         {
#           "id": "98236657",
#           "name": "Done"
#         },
#         {
#           "id": "0fd8f719",
#           "name": "Blocked"
#         }
#       ],
#       "type": "ProjectV2SingleSelectField"
#     },
#     {
#       "id": "PVTF_lAHOAC2_7c4Aa9R9zgRUW9A",
#       "name": "Labels",
#       "type": "ProjectV2Field"
#     },
#     {
#       "id": "PVTF_lAHOAC2_7c4Aa9R9zgRUW9E",
#       "name": "Linked pull requests",
#       "type": "ProjectV2Field"
#     },
#     {
#       "id": "PVTF_lAHOAC2_7c4Aa9R9zgRUW9M",
#       "name": "Reviewers",
#       "type": "ProjectV2Field"
#     },
#     {
#       "id": "PVTF_lAHOAC2_7c4Aa9R9zgRUW9Q",
#       "name": "Repository",
#       "type": "ProjectV2Field"
#     },
#     {
#       "id": "PVTF_lAHOAC2_7c4Aa9R9zgRUW9U",
#       "name": "Milestone",
#       "type": "ProjectV2Field"
#     },
#     {
#       "id": "PVTSSF_lAHOAC2_7c4Aa9R9zgRUYo4",
#       "name": "Type",
#       "options": [
#         {
#           "id": "a19a988b",
#           "name": "Task"
#         },
#         {
#           "id": "11903f04",
#           "name": "PR"
#         },
#         {
#           "id": "502cf27a",
#           "name": "Module"
#         },
#         {
#           "id": "dfc2a82c",
#           "name": "ToMaster"
#         }
#       ],
#       "type": "ProjectV2SingleSelectField"
#     },
#     {
#       "id": "PVTF_lAHOAC2_7c4Aa9R9zgRUZc0",
#       "name": "Boost PR",
#       "type": "ProjectV2Field"
#     },
#     {
#       "id": "PVTSSF_lAHOAC2_7c4Aa9R9zgSvuOA",
#       "name": "Merge By",
#       "options": [
#         {
#           "id": "3120f7b3",
#           "name": "Boost"
#         },
#         {
#           "id": "78215ab9",
#           "name": "Maintainer"
#         },
#         {
#           "id": "f530a0f7",
#           "name": "Other"
#         }
#       ],
#       "type": "ProjectV2SingleSelectField"
#     },
#     {
#       "id": "PVTF_lAHOAC2_7c4Aa9R9zgSvuv0",
#       "name": "Maintainer",
#       "type": "ProjectV2Field"
#     }
#   ],
#   "totalCount": 12
# }

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
            repo=`echo ${l_url} | grep -E 'boostorg[.]([^.]+)' -o`
            repo=${repo/boostorg./}
            echo "gh pr list --repo=boostorg/${repo} --head=modular --json=number | grep -E \"([0-9]+)\" -o"
            pr=`gh pr list --repo=boostorg/${repo} --head=modular --json=number | grep -E "([0-9]+)" -o`
            if test -n "${pr}" ; then
                echo PR number: ${pr}
                echo gh pr edit ${pr} --repo=boostorg/${repo} -F "${patchdir}/mod-pr-${1}.md"
                gh pr edit ${pr} --repo=boostorg/${repo} -F "${patchdir}/mod-pr-${1}.md"
            fi
            sleep 1
        fi
    else
        break
    fi
done < "${rootdir}/.gitmodules"

cd "${rootdir}"
echo "*****" `pwd`
