if ! test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/bash/bash_profile.d/01_path.sh"; fi

export PATH="${HOME}/.dotfiles/bash/bin/shared${PATH:+:${PATH}}"
export PATH="${HOME}/.dotfiles/bash/bin/user${PATH:+:${PATH}}"
export PATH="${HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bin${PATH:+:${PATH}}"
export PATH="${HOME}/.dotfiles/bash/${DOTFILES_TYPE}/user/bin${PATH:+:${PATH}}"

if ! test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/bash/bash_profile.d/01_path.sh"; fi