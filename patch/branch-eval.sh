set_branch ()
{
    echo GITHUB_BASE_REF: $GITHUB_BASE_REF
    echo GITHUB_REF_NAME: $GITHUB_REF_NAME
    BOOST_BRANCH=develop
    [[ -n "${GITHUB_REF_NAME}" ]] && BOOST_BRANCH=${GITHUB_REF_NAME}
    [[ "${GITHUB_REF_NAME}" =~ ^"feature/" ]] && BOOST_BRANCH=develop
    [[ -n "${GITHUB_BASE_REF}" ]] && BOOST_BRANCH=${GITHUB_BASE_REF}

    echo "REF:${GITHUB_REF_NAME}, BASE:${GITHUB_BASE_REF} ==> ${BOOST_BRANCH} <== ${1}"
}

GITHUB_REF_NAME=999/merge   && GITHUB_BASE_REF=master   && set_branch master
echo
GITHUB_REF_NAME=foobar      && GITHUB_BASE_REF=         && set_branch foobar
echo
GITHUB_REF_NAME=modular     && GITHUB_BASE_REF=         && set_branch modular
echo
GITHUB_REF_NAME=feature/xyz && GITHUB_BASE_REF=         && set_branch develop
