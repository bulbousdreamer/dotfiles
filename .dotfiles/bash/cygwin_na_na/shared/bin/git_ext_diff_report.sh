#!/usr/bin/env bash

# export DIFF_LOG_FOLDER="${HOME}/logs/somedescription/$(date "+%Y%m%d%H%M%S%N")_${PWD##*/}" && git difftool --tool=bc4report somecommitorwhatever

old_file="$(cygpath --mixed --absolute "${1}")"
new_file="$(cygpath --mixed --absolute "${2}")"
file_label="${new_file//\:/__}"
report_folder="$(cygpath --mixed --absolute "${3}")"
script_file="$(cygpath --mixed --absolute "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bin/bcdiff.txt")"
report_file="${report_folder}/${new_file//\//___}.html"

# Use latest installed version
bcomp_exe=

if [ -f "C:/Program Files/Beyond Compare 5/BComp.exe" ]; then
  bcomp_exe="C:/Program Files/Beyond Compare 5/BComp.exe"
elif [ -f "C:/Program Files/Beyond Compare 4/BComp.exe" ]; then
  bcomp_exe="C:/Program Files/Beyond Compare 4/BComp.exe"
else
  printf 'ERROR: Cannot find Beyond Compare. Exiting.\n'
  exit 1
fi

# If one of the files is /dev/null, use an empty file so bc4 does not error
# TODO: Should there be more if statements to check filemode?
if [ "${old_file}" == "/dev/null" -o "${old_file}" == "//./NUL" ]; then
    old_file="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/storage/null_file"
fi

if [ "${new_file}" == "/dev/null" -o "${new_file}" == "//./NUL" ]; then
    new_file="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/storage/null_file"
    file_label="${old_file//\:/__}"
fi

report_file="${report_folder}/${file_label//\//___}.html"
printf "report_file=%s\n" "${report_file}"

mkdir -p "${report_folder}"
touch "${report_file}"
"${bcomp_exe}" \
  @"$(cygpath --mixed --absolute "${script_file}")" \
  "$(cygpath --mixed --absolute "${old_file}")" \
  "$(cygpath --mixed --absolute "${new_file}")" \
  "$(cygpath --mixed --absolute "${report_file}")"
