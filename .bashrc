[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering .bashrc"

[[ "${DOTFILES_SHARED}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bashrc"
[[ "${DOTFILES_USER}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bashrc"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving .bashrc"
