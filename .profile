export DOTFILES_DEBUG
if test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/.profile"; fi

. "${HOME}/.dotfiles/bash/template/shared/bin/set_dotfiles_type.sh"
. "${HOME}/.dotfiles/bash/${DOTFILES_TYPE}/profile"
. "${HOME}/.bash_profile"

if test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/.profile"; fi