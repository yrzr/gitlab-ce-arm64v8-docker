#!/bin/bash

IFS='.' read -ra NUMS <<< ${CI_COMMIT_TAG}
echo "${NUMS[0]}-${NUMS[1]}-stable" > branch_name
