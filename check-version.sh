#!/bin/bash

SEARCH_PAGES='10'

if [ -f ./version_list ]; then
    rm version_list
fi

for i in $(seq 1 ${SEARCH_PAGES}); do
    curl -s "https://packages.gitlab.com/gitlab/gitlab-ce?page=${i}" | grep "_arm64.deb" | grep -v '\-rc' | sed 's/.*>\(.*\)<.*/\1/' | sort -u | sed 's/gitlab-ce_\(.*\)_arm64.deb/\1/' >> version_list;
done
sort -rVu version_list -o version_list
