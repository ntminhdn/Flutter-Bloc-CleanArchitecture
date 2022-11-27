#!/bin/zsh
echo "Checking your branch name"
LC_ALL=C

local_branch="$(git rev-parse --abbrev-ref HEAD)"

valid_branch_regex='^(feature|bugfix|improvement|release|hotfix)\/NFT-[0-9]+_.*$'

message="$local_branch is bad branch name. See example: feature/NFT-2_some_text"

#if [[ $local_branch == "flutter_template" ]]
#then
#    exit 0
#fi

if [[ ! $local_branch =~ $valid_branch_regex ]]
then
    echo "$message"
    exit 1
fi

exit 0