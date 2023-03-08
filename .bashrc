export DOTFILES_DEBUG
if ! test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/.bashrc"; fi

. "${HOME}/.dotfiles/bash/template/shared/bin/set_dotfiles_type.sh"
. "${HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bashrc"
. "${HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bashrc"

if ! test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/.bashrc"; fi