#!/bin/bash

cat version_list | while read version; do
    HAVE_TAG=false

    for tag in $(git tag); do
        if [ "${version}" == "${tag}" ]; then
            HAVE_TAG=true
            break
        fi
    done

    if ! ${HAVE_TAG}; then
        echo "Creating and pushing tag ${version}"
        git tag ${version}
        git push origin ${version}
    else
        echo "Tag ${version} already exists, skipping"
    fi
done
