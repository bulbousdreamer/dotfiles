[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Entering ${DOTFILES_HOME}/.dotfiles/bash/bash_profile.d/shared/history.sh"

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
# export PROMPT_COMMAND="history -a"
# Append history to HISTFILE and make available in terminal when PROMPT displays
export PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+;${PROMPT_COMMAND}}"

export HISTFILE="${DOTFILES_HOME}/.dotfiles/bash/${DOTFILES_TYPE}/shared/bash_history"

export HISTSIZE=5000

# Make bash append rather than overwrite the history on disk
shopt -s histappend

[[ "${DOTFILES_DEBUG}" = "true" ]] && echo "Leaving ${DOTFILES_HOME}/.dotfiles/bash/bash_profile.d/shared/history.sh"