dotfiles_os_type=
case "$(uname --operating-system 2>/dev/null ):$(domainname 2>/dev/null):$(hostname 2>/dev/null )" in
    Cygwin:*:*)
        dotfiles_os_type="cygwin_laptop"
        ;;
    *:*:*)
        dotfiles_os_type="template"
        ;;
esac

echo "${dotfiles_os_type}"
