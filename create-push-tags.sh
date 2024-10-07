#!/bin/bash

cat version_list | while read version; do
    echo ${version}
    HAVE_TAG=false
    for tag in $(git tag); do
        if [ "${version}" == "${tag}" ]; then
            HAVE_TAG=true
        fi
    done
    if ! ${HAVE_TAG}; then
        git tag ${version}
        git push origin ${version}
    fi
done
