dotfiles_os_type=
case "$(uname --operating-system 2>/dev/null):$(domainname 2>/dev/null):$(hostname 2>/dev/null)" in
    Cygwin:*:*)
        dotfiles_os_type="cygwin_na_na"
        ;;
    *:*:*)
        dotfiles_os_type="dotfiles_type_template"
        ;;
esac

echo "${dotfiles_os_type}"
