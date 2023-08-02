#!/usr/bin/env bash

# export DIFF_LOG_FOLDER="${HOME}/logs/somedescription/$(date "+%Y%m%d%H%M%S%N")_${PWD##*/}" && git difftool --tool=bc4report somecommitorwhatever

old_file="$(cygpath --mixed --absolute "${1/cygdrive/proc\/cygdrive}")"
new_file="$(cygpath --mixed --absolute "${2/cygdrive/proc\/cygdrive}")"
file_label="${new_file//\:/__}"
report_folder="$(cygpath --mixed --absolute "${3/cygdrive/proc\/cygdrive}")"
script_file="$(cygpath --mixed --absolute "${DOTFILES_HOME/cygdrive/proc\/cygdrive}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bin/bcdiff.txt")"
report_file="${report_folder}/${new_file//\//___}.html"

if [ "${old_file}" == "/dev/null" ]; then
    old_file="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/storage/null_file"
fi

if [ "${new_file}" == "/dev/null" ]; then
    new_file="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/storage/null_file"
    file_label="${old_file//\:/__}"
fi

report_file="${report_folder}/${file_label//\//___}.html"
printf "report_file=%s\n" "${report_file}"

mkdir -p "${report_folder}"
touch "${report_file}"
"C:/Program Files/Beyond Compare 4/BCompare.exe" \
  @"$(cygpath --mixed --absolute "${script_file}")" \
  "$(cygpath --mixed --absolute "${old_file}")" \
  "$(cygpath --mixed --absolute "${new_file}")" \
  "$(cygpath --mixed --absolute "${report_file}")"
