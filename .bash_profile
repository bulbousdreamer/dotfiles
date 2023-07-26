export DOTFILES_DEBUG="true"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.bash_profile"

export DOTFILES_HOME="${DOTFILES_HOME:="$(cygpath --mixed --absolute "${HOME}")"}"
export DOTFILES_REPO="${DOTFILES_REPO:="$(cygpath --mixed --absolute "${HOME}/git/dotfiles/.git")"}"
export DOTFILES_TYPE="${DOTFILES_TYPE:="$("${DOTFILES_HOME}/.dotfiles/bash/shared/bin/set_dotfiles_type.sh")"}"
export DOTFILES_SHARED="${DOTFILES_SHARED:="true"}"
export DOTFILES_USER="${DOTFILES_USER:="true"}"

##### Start modular bash_profile #####
# https://github.com/detro/.bashrc.d
# Source common settings for all OS's
bash_profiles=()
while IFS= read -d '' -r; do
	bash_profiles+=("${REPLY}")
done < <(find "${DOTFILES_HOME}/.dotfiles/bash/shared/bash_profile.d" -mindepth 1 -maxdepth 1 -type f -name '*.sh' -print0)

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
