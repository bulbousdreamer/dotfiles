[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.profile"

##### Start modular profile #####
profiles=()
while IFS= read -d '' -r; do
	profiles+=("${REPLY}")
done < <(find "${DOTFILES_HOME}/.dotfiles/bash/profile.d/shared" -mindepth 1 -maxdepth 1 -type f -name '*.sh' -print0)

for profile in "${profiles[@]}"; do
  [[ "${DOTFILES_SHARED}" = "true" ]] && . "${profile}"
done

profiles=()
while IFS= read -d '' -r; do
	profiles+=("${REPLY}")
done < <(find "${DOTFILES_HOME}/.dotfiles/bash/profile.d/user" -mindepth 1 -maxdepth 1 -type f -name '*.sh' -print0)

for profile in "${profiles[@]}"; do
  [[ "${DOTFILES_USER}" = "true" ]] && . "${profile}"
done
##### End modular profile #####

[[ "${DOTFILES_SHARED}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/profile"
[[ "${DOTFILES_USER}" = "true" ]] && . "${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/profile"
. "${DOTFILES_HOME}/.bash_profile"

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving ${DOTFILES_HOME}/.profile"
