#
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly command line
# https://fishshell.com/

bass source "$HOME/.config/shell/env.sh"

zoxide   init fish | source # 'ajeetdsouza/zoxide'
starship init fish | source # https://starship.rs/

set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_default_key_bindings

# fnm
fnm --log-level quiet env --use-on-cd | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
