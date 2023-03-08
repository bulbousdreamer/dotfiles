#!/bin/bash

new_dir="${1}"

mkdir ../${new_dir} && cd ../${new_dir} || exit 1
cd ../${new_dir} || exit 1
cp -r ../template/shared . || exit 1
cp -r ../template/user . || exit 1
find . -type f -exec sed -i -e "s/DOTFILES_OS_PLACEHOLDER/${new_dir}/g" {} \;