#!/bin/bash
echo "Checking commit message..."
commit_message=`git log --format=%B -n 1 $BITBUCKET_COMMIT`

if [[ ! $commit_message =~ ^[[]NFT-[0-9]+][[:space:]][[:alnum:][:punct:][:space:]]+$ ]]; then
    echo "Commit message \"$commit_message\" is invalid. See example: \"[NFT-2] some text\""
    exit 1
fi

echo "Commit message \"$commit_message\" is valid"
