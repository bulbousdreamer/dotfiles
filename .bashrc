export DOTFILES_DEBUG
if ! test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/.bashrc"; fi

export DOTFILES_HOME="${HOME}"
export DOTFILES_REPO="${HOME}/git/dotfiles/.git"

. "${DOTFILES_HOME}/.dotfiles/bash/bin/shared/set_dotfiles_type.sh"
. "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bashrc"
. "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bashrc"

if ! test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/.bashrc"; fi