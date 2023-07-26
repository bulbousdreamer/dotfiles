export DOTFILES_DEBUG="true"
export DOTFILES_HOME="${DOTFILES_HOME:="${HOME}"}"
export DOTFILES_REPO="${DOTFILES_REPO:="${HOME}/git/dotfiles/.git"}"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.bashrc"

export DOTFILES_TYPE="${DOTFILES_TYPE:="$("${DOTFILES_HOME}/.dotfiles/bash/shared/bin/set_dotfiles_type.sh")"}"
export DOTFILES_SHARED="${DOTFILES_SHARED:="true"}"
export DOTFILES_USER="${DOTFILES_USER:="true"}"

##### Start modular bashrc #####
bashrcs=()
while IFS= read -d '' -r; do
	bashrcs+=("${REPLY}")
done < <(find "${DOTFILES_HOME}/.dotfiles/bash/shared/bashrc.d" -mindepth 1 -maxdepth 1 -type f -name '*.sh' -print0)

for bashrc in "${bashrcs[@]}"; do
  [[ "${DOTFILES_SHARED}" = "true" ]] && . "${bashrc}"
done

bashrcs=()
while IFS= read -d '' -r; do
	bashrcs+=("${REPLY}")
done < <(find "${DOTFILES_HOME}/.dotfiles/bash/bashrc.d/user" -mindepth 1 -maxdepth 1 -type f -name '*.sh' -print0)

for bashrc in "${bashrcs[@]}"; do
  [[ "${DOTFILES_USER}" = "true" ]] && . "${bashrc}"
done
##### End modular bashrc #####

[[ "${DOTFILES_SHARED}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bashrc"
[[ "${DOTFILES_USER}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bashrc"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving ${DOTFILES_HOME}/.bashrc"
