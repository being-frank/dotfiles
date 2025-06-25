#!/usr/bin/zsh

local search_path
local tool_versions_file_path
search_path=$(pwd)

while [ $search_path != '/' ]; do
  if [ -f "$search_path/.tool-versions" ]; then
    tool_versions_file_path="$search_path/.tool-versions"
  fi
  search_path=$(dirname $search_path)
done

if [ $tool_versions_file_path ]; then
  grep -w $1 $tool_versions_file_path | cut -d ' ' -f 2
else
  return 1
fi
