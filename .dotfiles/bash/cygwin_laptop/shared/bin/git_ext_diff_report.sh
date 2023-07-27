#!/usr/bin/env bash

printf "1=%s\n" "${1}"
printf "2=%s\n" "${2}"
printf "3=%s\n" "${3}"

old_file="$(cygpath --mixed --absolute "${1/cygdrive/proc\/cygdrive}")"
new_file="$(cygpath --mixed --absolute "${2/cygdrive/proc\/cygdrive}")"
file_label="${new_file//\:/__}"
report_folder="$(cygpath --mixed --absolute "${3/cygdrive/proc\/cygdrive}")"
script_file="$(cygpath --mixed --absolute "${DOTFILES_HOME/cygdrive/proc\/cygdrive}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bin/bcdiff.txt")"
report_file="${report_folder}/${new_file//\//___}.html"

# $(sed -e 's,/,___/g;s,:,___/g' <<< $V)

printf "old_file=%s\n" "${old_file}"
printf "new_file=%s\n" "${new_file}"
printf "report_folder=%s\n" "${report_folder}"
printf "script_file=%s\n" "${script_file}"
printf "file_label=%s\n" "${file_label}"

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
echo "C:/Program Files/Beyond Compare 4/BCompare.exe" \
  @"$(cygpath --mixed --absolute "${script_file}")" \
  "$(cygpath --mixed --absolute "${old_file}")" \
  "$(cygpath --mixed --absolute "${new_file}")" \
  "$(cygpath --mixed --absolute "${report_folder}")"
