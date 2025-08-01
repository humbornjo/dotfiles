#
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly command line
# https://fishshell.com/

eval (/opt/homebrew/bin/brew shellenv)
zoxide   init fish | source # 'ajeetdsouza/zoxide'
starship init fish | source # https://starship.rs/

set -U fish_greeting # disable fish greeting
set -U LANG en_US.UTF-8
set -U LC_ALL en_US.UTF-8

# just found <C-x>e for fish as <M-v>, sayonara vi-mode, emacs-mode first
set -U fish_key_bindings fish_default_key_bindings

set -Ux SHELL "bash"
set -Ux EDITOR "nvim" # 'neovim/neovim' text editor
set -Ux VISUAL "nvim"
set -Ux PAGER "less"
set -Ux EZA_CONFIG_DIR "$HOME/.config/eza"
set -Ux BAT_CONFIG_PATH "$HOME/.config/bat/config" # 'sharkdp/bat' cat clone
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"
set -Ux KUBECONFIG "$HOME/.kube/config"

# golang
set -Ux GOPATH "$HOME/Library/go"
fish_add_path $GOPATH/bin

# rust
set -Ux CARGO_HOME "$HOME/.cargo"
set -Ux RUSTUP_HOME "$HOME/.rustup"
fish_add_path $CARGO_HOME/bin

# fnm
fnm --log-level quiet env --use-on-cd | source

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# fvm: flutter version manager
set -Ux FVM_HOME "$HOME/.fvm"
fish_add_path $FVM_HOME/default/bin

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1];
or set GHCUP_INSTALL_BASE_PREFIX $HOME;
set -gx PATH $HOME/.cabal/bin $PATH /Users/humborn/.ghcup/bin

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
