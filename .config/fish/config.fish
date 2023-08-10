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
eval "$(pyenv init -)"
starship init fish | source # https://starship.rs/
zoxide init fish | source # 'ajeetdsouza/zoxide'
fnm --log-level quiet env --use-on-cd | source

set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings
set -U LANG en_US.UTF-8
set -U LC_ALL en_US.UTF-8

set -Ux EDITOR "nvim" # 'neovim/neovim' text editor
set -Ux VISUAL "nvim"
set -Ux PAGER "nvimpager" # 'lucc/nvimpager'
set -Ux BAT_CONFIG_PATH "$HOME/.config/bat/config" # 'sharkdp/bat' cat clone
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"
set -Ux KUBECONFIG "$HOME/.kube/config"

# personal config
fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin
fish_add_path $HOME/.config/bin # my custom scripts

# golang 
set -Ux GOPATH "$HOME/Library/go"
fish_add_path $GOPATH/bin

# rust 
set -Ux CARGO_HOME "$HOME/.cargo"
set -Ux RUSTUP_HOME "$HOME/.rustup"
fish_add_path $CARGO_HOME/bin

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# fvm: flutter version manager 
set -Ux FVM_HOME "$HOME/.fvm"
fish_add_path $FVM_HOME/default/bin

# pyenv: disable some unpleasent msg
set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; 
or set GHCUP_INSTALL_BASE_PREFIX $HOME; 
set -gx PATH $HOME/.cabal/bin $PATH /Users/humborn/.ghcup/bin

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
