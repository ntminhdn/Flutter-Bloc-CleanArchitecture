#!/bin/zsh
declare -A version_maps
echo "${ZSH_VERSION}"
parent_path=$( cd "$(dirname "${(%):-%N}")" ; pwd -P ) # nals_flutter_project_template/tools
root_project_path=$(dirname $parent_path)

# echo $root_project_path

pubspec_app_path="$root_project_path/app/pubspec.yaml"
# echo $pubspec_app_path
pubspec_data_path="$root_project_path/data/pubspec.yaml"
pubspec_domain_path="$root_project_path/domain/pubspec.yaml"
pubspec_shared_path="$root_project_path/shared/pubspec.yaml"
pubspec_initializer_path="$root_project_path/initializer/pubspec.yaml"
pubspec_resources_path="$root_project_path/resources/pubspec.yaml"
pubspec_nals_lints_path="$root_project_path/nals_lints/pubspec.yaml"

pubspec_versions_path="$root_project_path/pub_versions.yaml"

pubspec_app=$(< $pubspec_app_path)
regex_pub_and_version="^\s+\w+:\s*\d+\..*"
pub_and_versions=$( grep -E $regex_pub_and_version "$pubspec_versions_path" )
regex_pub_name="[A-Za-z_]+:\s\d" #output sample: analyzer: 2
pub_names=$( grep -oE $regex_pub_name "$line" )

n=1
while read line; do
    if [[ $line =~ ^[A-Za-z_]+:[[:space:]]*[0-9]+.*$ ]]; then
        version_maps["${line%:*}"]="  $line" # and two space and remove version, Ex output: bloc_test
    fi
done < $pubspec_versions_path

replaceVersions() {
    echo "=====$1====="
    n=1
    while read line; do
        if [[ $line =~ ^[A-Za-z_]+:[[:space:]][0-9].*$ ]]; then
            value=${version_maps["${line%:*}"]}
            if [[ -n $value && "  $line" != $value ]]; then
                echo "replaced $line by $value"
                sed -i '' "${n}s/.*/$value/" $1
            fi
        fi

        n=$((n+1))
    done < $1
}

replaceVersions $pubspec_app_path
replaceVersions $pubspec_data_path
replaceVersions $pubspec_domain_path
replaceVersions $pubspec_shared_path
replaceVersions $pubspec_initializer_path
replaceVersions $pubspec_resources_path
replaceVersions $pubspec_nals_lints_path
