#!/usr/bin/env bash

path="${1}"
old_file="$(cygpath --mixed --absolute "${2}")"
old_hex="${3}"
old_mode="${4}"
new_file="${5}"
new_hex="${6}"
new_mode="${7}"

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

# If the files are the same, including mode, do not open them in the bc4 GUI
if [ "$(cmp --silent "${old_file}" "${new_file}")" -a "${old_mode}" = "${new_mode}" ]; then
    exit 0
fi

# If one of the files is /dev/null, use an empty file so bc does not error
if [ "${old_file}" == "/dev/null" -o "${old_file}" == "//./NUL" ]; then
    old_file="$(cygpath --mixed --absolute "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/storage/null_file")"
fi

if [ "${new_file}" == "/dev/null" -o "${new_file}" == "//./NUL" ]; then
    new_file="$(cygpath --mixed --absolute "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/storage/null_file")"
fi

# Open the GUI
"${bcomp_exe}" \
  "$(cygpath --mixed --absolute "${old_file}")" \
  "$(cygpath --mixed --absolute "${new_file}")" \
  //silent \
  //lefttitle="hex=${old_hex}. mode=${old_mode}." \
  //righttitle="hex=${new_hex}. mode=${new_mode}."

return_status=$?

# TODO check for and display more granular error codes?
# https://www.scootersoftware.com/v5help/command_line_reference.html
if [ ${return_status} -lt 100 ]; then
    exit 0
else
    exit 1
fi
