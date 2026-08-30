#!/usr/bin/env bash

local_file="${1}"
remote_file="${2}"
base_file="${3}"
merged_file="${4}"

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

"${bcomp_exe}" \
  "$(cygpath --mixed --absolute "${local_file}")" \
  "$(cygpath --mixed --absolute "${remote_file}")" \
  "$(cygpath --mixed --absolute "${base_file}")" \
  /mergeoutput="$(cygpath --mixed --absolute "${merged_file}")"

return_status="${?}"

if [ ${return_status} -lt 100 ]; then
    exit 0
else
    exit 1
fi
