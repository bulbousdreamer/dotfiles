export DOTFILES_DEBUG
if test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/.bash_profile"; fi

. "${HOME}/.dotfiles/bash/template/shared/bin/set_dotfiles_type.sh"
. "${HOME}/.dotfiles/bash/${DOTFILES_TYPE}/bash_profile"
. "${HOME}/.bashrc"

if test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/.bash_profile"; fi