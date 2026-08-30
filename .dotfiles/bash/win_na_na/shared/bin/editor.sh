#!/usr/bin/env bash

# TODO use this script to only call another script
# For example, configure various editors like notepad++
# Then call the preferred one like npp.sh from this script

exe=

if [ -f "C:/Program Files/Notepad++/notepad++.exe" ]; then
  exe="C:/Program Files/Notepad++/notepad++.exe"
elif [ -f "C:/Program Files (x86)/Notepad++/notepad++.exe" ]; then
  exe="C:/Program Files (x86)/Notepad++/notepad++.exe"
else
  printf 'ERROR: Cannot find Notepad++. Exiting.\n'
  exit 1
fi

for afile in "${@}"; do
  "$(cygpath --unix --absolute "${exe}")" \
    "$(cygpath --mixed --absolute "${afile}")" &
done
