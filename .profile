export DOTFILES_DEBUG
if ! test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/.profile"; fi

export DOTFILES_HOME="${HOME}"
export DOTFILES_REPO="${HOME}/git/dotfiles/.git"

. "${DOTFILES_HOME}/.dotfiles/bash/template/shared/bin/set_dotfiles_type.sh"
. "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/profile"
. "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/profile"
. "${DOTFILES_HOME}/.bash_profile"

if ! test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/.profile"; fi