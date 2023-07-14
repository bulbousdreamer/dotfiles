export DOTFILES_DEBUG="true"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering .bash_profile"

export DOTFILES_HOME="${HOME}"
export DOTFILES_REPO="${HOME}/git/dotfiles/.git"
. "${DOTFILES_HOME}/.dotfiles/bash/bin/shared/set_dotfiles_type.sh"

export DOTFILES_SHARED="true"
export DOTFILES_USER="true"
[[ "${DOTFILES_SHARED}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bash_profile"
[[ "${DOTFILES_USER}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bash_profile"
. "${DOTFILES_HOME}/.bashrc"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving .bash_profile"
