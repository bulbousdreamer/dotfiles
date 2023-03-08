export DOTFILES_DEBUG
if ! test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/.bash_profile"; fi

. "${HOME}/.dotfiles/bash/template/shared/bin/set_dotfiles_type.sh"

# https://github.com/detro/.bashrc.d
# Source common settings for all OS's
bash_profiles=()
while IFS= read -d '' -r; do
	bash_profiles+=("${REPLY}")
done < <(find "${HOME}/.dotfiles/bash/bash_profile.d" -mindepth 1 -maxdepth 1 -type f -name '*.sh' -print0)

for bash_profile in "${bash_profiles[@]}"; do
  . "${bash_profile}"
done

. "${HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bash_profile"
. "${HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bash_profile"
. "${HOME}/.bashrc"

if ! test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/.bash_profile"; fi