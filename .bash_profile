export DOTFILES_DEBUG
if ! test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/.bash_profile"; fi

export DOTFILES_HOME="${HOME}"
export DOTFILES_REPO="${HOME}/git/dotfiles/.git"

. "${DOTFILES_HOME}/.dotfiles/bash/bin/shared/set_dotfiles_type.sh"

# https://github.com/detro/.bashrc.d
# Source common settings for all OS's
bash_profiles=()
while IFS= read -d '' -r; do
	bash_profiles+=("${REPLY}")
done < <(find "${DOTFILES_HOME}/.dotfiles/bash/bash_profile.d" -mindepth 1 -maxdepth 1 -type f -name '*.sh' -print0)

for bash_profile in "${bash_profiles[@]}"; do
  . "${bash_profile}"
done

. "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bash_profile"
. "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bash_profile"
. "${DOTFILES_HOME}/.bashrc"

if ! test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/.bash_profile"; fi