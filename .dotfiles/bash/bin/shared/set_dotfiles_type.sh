if ! test "${DOTFILES_DEBUG+define}"; then echo "Entering .dotfiles/bash/template/shared/bin/set_dotfiles_type.sh"; fi

if ! test "${DOTFILES_TYPE}"; then
  export DOTFILES_TYPE
    case "$(uname -o):$(hostname)" in
        Cygwin:*)
            DOTFILES_TYPE=cyg
            ;;
        GNU/Linux:*oscer.ou.edu)
                    DOTFILES_TYPE=oscer
                    ;;
        *)
            # use empty files and avoid errors
            DOTFILES_TYPE=template
            ;;
    esac
# TODO: detect Linux https://unix.stackexchange.com/a/6348
fi

if ! test "${DOTFILES_DEBUG+define}"; then echo "Leaving .dotfiles/bash/template/shared/bin/set_dotfiles_type.sh"; fi