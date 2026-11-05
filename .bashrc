case $- in
  *i*) ;;
  *) return 0 ;;
esac

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"
command -v fnm >/dev/null 2>&1 && eval "$(fnm --log-level quiet env --use-on-cd --shell bash)"
