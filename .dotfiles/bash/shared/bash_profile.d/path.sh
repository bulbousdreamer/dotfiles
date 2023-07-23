[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.dotfiles/bash/shared/bash_profile.d/path.sh"

export PATH="${DOTFILES_HOME}/.dotfiles/bash/shared/bin${PATH:+:${PATH}}"
PATH="${DOTFILES_HOME}/.dotfiles/bash/user/bin${PATH:+:${PATH}}"
PATH="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bin${PATH:+:${PATH}}"
PATH="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bin${PATH:+:${PATH}}"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving ${DOTFILES_HOME}/.dotfiles/bash/shared/bash_profile.d/path.sh"
