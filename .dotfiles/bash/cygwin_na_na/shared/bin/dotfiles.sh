#!/usr/bin/env bash

[[ -e "${DOTFILES_REPO}" ]]  || { printf "DOTFILES_REPO is set to \"%s\" which does not exist." "${DOTFILES_REPO}"; exit 1; }
[[ -d "${DOTFILES_HOME}" ]]  || { printf "DOTFILES_HOME is set to \"%s\" which is not a directory." "${DOTFILES_HOME}"; exit 1; }

git_dir="$(cygpath --mixed --absolute ${DOTFILES_REPO})"
work_tree="$(cygpath --mixed --absolute ${DOTFILES_HOME})"

disabled=$(git --git-dir="${git_dir}" --work-tree="${work_tree}" config --bool disabled.${1} 2>/dev/null)

if ${disabled:-false}; then
    print "The %s command is intentionally disabled by this function.\ " "${1}"
    print "Cautiously run the disabled command by calling git with correct parameters instead:\n"
    print "git --git-dir=%s --work-tree=%s ...\n" "${git_dir}" "${work_tree}"
    exit 1
fi

# Sets the git directory to the dotfiles repo and work tree to home
git --git-dir="${git_dir}" --work-tree="${work_tree}" -c status.showUntrackedFiles=no "$@"
