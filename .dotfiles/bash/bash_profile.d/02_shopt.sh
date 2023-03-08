if ! test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/bash/bash_profile.d/02_shopt.sh"; fi

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Help with line wrapping hopefully
shopt -s checkwinsize

if ! test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/bash/bash_profile.d/02_shopt.sh"; fi