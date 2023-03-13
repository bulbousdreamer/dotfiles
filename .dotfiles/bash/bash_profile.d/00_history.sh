if ! test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/bash/bash_profile.d/00_history.sh"; fi

# History Options
#
# Don't put duplicate lines in the history and ignore commands beginning with space
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoreboth
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
export HISTFILE="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/bash_history"

export HISTSIZE=5000

# Append history to HISTFILE and make available in terminal when PROMPT displays
export PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+;${PROMPT_COMMAND}}"

# Make bash append rather than overwrite the history on disk
shopt -s histappend

if ! test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/bash/bash_profile.d/00_history.sh"; fi