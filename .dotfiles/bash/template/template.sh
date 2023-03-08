#!/bin/bash

new_dir="${1}"

mkdir ../${new_dir} && cd ../${new_dir} || exit 1
cd ../${new_dir} || exit 1
cp -r ./template/shared .
cp -r ./template/user .
find . -type f -exec sed -i -e "s/DOTFILES_OS_PLACEHOLDER/${new_dir}/g" {} \;