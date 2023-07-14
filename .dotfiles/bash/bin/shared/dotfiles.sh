#!/usr/bin/bash

git_dir="${DOTFILES_REPO}"
dotfiles_dir="${DOTFILES_HOME}"

disabled=$(git --git-dir="${git_dir}" --work-tree="${dotfiles_dir}" config --bool disabled.${1} 2>/dev/null)

if ${disabled:-false}; then
    print "The %s command is intentionally disabled by this function.\ " "${1}"
    print "Cautiously run the disabled command by calling git with correct parameters instead:\n"
    print "git --git-dir=%s --work-tree=%s ...\n" "${git_dir}" "${dotfiles_dir}"
    exit 1
fi

# Sets the git directory to the dotfiles repo and work tree to home
git --git-dir="${git_dir}" --work-tree="${dotfiles_dir}" -c status.showUntrackedFiles=no "$@"
