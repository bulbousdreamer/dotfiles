[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bash_profile.d/path.sh"

# Have Cygwin use Git Bash version of Git if it is installed
# I forget why, but I think the Git Bash was updated sooner
PATH="$(cygpath --unix --absolute 'C:/Program Files/Git/mingw64/bin')${PATH:+:${PATH}}"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving ${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bash_profile.d/path.sh"
