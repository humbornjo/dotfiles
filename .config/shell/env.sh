# Shared environment for POSIX shells and Fish (through Bass).

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export SHELL=bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

export EZA_CONFIG_DIR="$HOME/.config/eza"
export BAT_CONFIG_PATH="$HOME/.config/bat/config"
export FZF_DEFAULT_COMMAND="fd -H -E '.git'"
export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-ms:$HOME/.kube/config-ms-prod"

export GOPATH="$HOME/Library/go"
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export FVM_HOME="$HOME/.fvm"
export PNPM_HOME="$HOME/Library/pnpm"
export GHCUP_INSTALL_BASE_PREFIX="${GHCUP_INSTALL_BASE_PREFIX:-$HOME}"

path_prepend() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1:$PATH" ;;
  esac
}

path_append() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$PATH:$1" ;;
  esac
}

path_append "$HOME/.krew/bin"
path_append "$HOME/.ghcup/bin"
path_append "$HOME/.orbstack/bin"

path_prepend "$PNPM_HOME"
path_prepend "$PNPM_HOME/bin"
path_prepend "$HOME/.cabal/bin"

# Preserve legacy Kimi installations when those accounts exist.
[ ! -d /Users/moonshot/.kimi-code/bin ] || path_prepend /Users/moonshot/.kimi-code/bin
[ ! -d /Users/user/.kimi-code/bin ] || path_prepend /Users/user/.kimi-code/bin

# Include paths previously persisted by fish_add_path. Reverse prepend order
# retains their existing priority, with the current Kimi installation first.
path_prepend "$CARGO_HOME/bin"
path_prepend /usr/local/go/bin
path_prepend /opt/homebrew/opt/llvm/bin
path_prepend "$HOME/.emacs.d/bin"
path_prepend /opt/homebrew/opt/libpq/bin
path_prepend "$FVM_HOME/default/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$GOPATH/bin"
path_prepend "$HOME/.kimi-code/bin"

export PATH

if [ -r "$HOME/.config/shell/env.local.sh" ]; then
  . "$HOME/.config/shell/env.local.sh"
fi
