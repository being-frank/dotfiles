#!/usr/bin/zsh

local search_path
local node_version_file_path
search_path=$(pwd)

while [ $search_path != '/' ]; do
  if [ -f "$search_path/.nvmrc" ]; then
    node_version_file_path="$search_path/.nvmrc"
  elif [ -f "$search_path/.node-version" ]; then
    node_version_file_path="$search_path/.node-version"
  fi
  search_path=$(dirname $search_path)
done

if [ $node_version_file_path ]; then
  head -n 1 "$node_version_file_path"
else
  version=$(node -v)
  if [ $version ]; then
    echo "$version﹡"
  fi
fi
