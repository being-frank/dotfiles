#!/usr/bin/zsh

local search_path
local ruby_version_file_path
search_path=$(pwd)

while [ $search_path != '/' ]; do
  if [ -f "$search_path/.ruby-version" ]; then
    ruby_version_file_path="$search_path/.ruby-version"
  fi
  search_path=$(dirname $search_path)
done

if [ $ruby_version_file_path ]; then
  head -n 1 "$ruby_version_file_path"
else
  version=$(ruby -v | awk '{print $2}')
  if [ $version ]; then
    echo "$version•"
  fi
fi
