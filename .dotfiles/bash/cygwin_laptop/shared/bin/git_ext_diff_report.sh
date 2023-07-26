#!/usr/bin/env bash
reminder that if new/old is null then the file name should come from old/new

old_file="${1}"
new_file="${2}"
report_folder="${3}"
script_file="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/storage/bcdiff.txt"

if [ "${old_file}" == "/dev/null" ]; then
    old_file="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/storage/null_file"
    report_file="${report_folder}/$(echo "${new_file}" | sed 's,/,___,g').html"
fi

if [ "${new_file}" == "/dev/null" ]; then
    new_file="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/storage/null_file"
    report_file="${report_folder}/$(echo "${old_file}" | sed 's,/,___,g').html"
fi

mkdir -p "${report_folder}"
touch "${report_file}"
"$(cygpath --unix --absolute "C:/Program Files/Beyond Compare 4/BCompare.exe")" \
  @"$(cygpath --mixed --absolute "${script_file}")" \
  "$(cygpath --mixed --absolute "${old_file}")" \
  "$(cygpath --mixed --absolute "${new_file}")" \
  "$(cygpath --mixed --absolute "${report_file}")"
