#!/usr/bin/env bash

new_dir="${1}"

mkdir ../${new_dir} && cd ../${new_dir} || exit 1
cd ../${new_dir} || exit 1
cp -r ../dotfiles_type_template/shared . || exit 1
cp -r ../dotfiles_type_template/user . || exit 1
