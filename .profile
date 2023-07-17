[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.profile"

[[ "${DOTFILES_SHARED}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bashrc"
[[ "${DOTFILES_USER}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bashrc"
. "${DOTFILES_HOME}/.bash_profile"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving ${DOTFILES_HOME}/.profile"
