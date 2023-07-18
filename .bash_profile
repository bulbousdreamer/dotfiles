export DOTFILES_DEBUG="true"
export DOTFILES_HOME="${DOTFILES_HOME:="${HOME}"}"
export DOTFILES_REPO="${DOTFILES_REPO:="${HOME}/git/dotfiles/.git"}"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.bash_profile"

. "${DOTFILES_HOME}/.dotfiles/bash/bin/shared/set_dotfiles_type.sh"

export DOTFILES_SHARED="true"
export DOTFILES_USER="true"

##### Start modular bash_profile #####
# https://github.com/detro/.bashrc.d
# Source common settings for all OS's
bash_profiles=()
while IFS= read -d '' -r; do
	bash_profiles+=("${REPLY}")
done < <(find "${DOTFILES_HOME}/.dotfiles/bash/bash_profile.d/shared" -mindepth 1 -maxdepth 1 -type f -name '*.sh' -print0)

for bash_profile in "${bash_profiles[@]}"; do
  [[ "${DOTFILES_SHARED}" = "true" ]] && . "${bash_profile}"
done

bash_profiles=()
while IFS= read -d '' -r; do
	bash_profiles+=("${REPLY}")
done < <(find "${DOTFILES_HOME}/.dotfiles/bash/bash_profile.d/user" -mindepth 1 -maxdepth 1 -type f -name '*.sh' -print0)

for bash_profile in "${bash_profiles[@]}"; do
  [[ "${DOTFILES_USER}" = "true" ]] && . "${bash_profile}"
done
##### End modular bash_profile #####

[[ "${DOTFILES_SHARED}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bash_profile"
[[ "${DOTFILES_USER}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bash_profile"
. "${DOTFILES_HOME}/.bashrc"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving ${DOTFILES_HOME}/.bash_profile"
