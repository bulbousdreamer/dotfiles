[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bash_profile.d/path.sh"

PATH="$(cygpath -ma 'C:/Program Files/Git/mingw64/bin')${PATH:+:${PATH}}"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving ${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bash_profile.d/path.sh"
