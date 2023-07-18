[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.dotfiles/bash/bash_profile.d/shared/path.sh"

export PATH="${DOTFILES_HOME}/.dotfiles/bash/bin/shared${PATH:+:${PATH}}"
PATH="${DOTFILES_HOME}/.dotfiles/bash/bin/user${PATH:+:${PATH}}"
PATH="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bin${PATH:+:${PATH}}"
PATH="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bin${PATH:+:${PATH}}"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving ${DOTFILES_HOME}/.dotfiles/bash/bash_profile.d/shared/path.sh"