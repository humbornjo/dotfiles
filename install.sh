# Do the following two line first
cd ~ && mkdir -p Repository && cd Repository
git clone git@github.com:humbornjo/dotfiles.git dotfiles

# font alternate to SF Mono (IMO)
brew install font-iosevka-nerd-font

brew install fish
brew install tmux
brew install sesh
brew install yazi                       # terminal file manager
brew install stow
brew install neovim
brew install zoxide
brew install mackup
brew install starship

brew install wget
brew install curl
brew install tree
brew install tokei
brew install fd                         # sub for find
brew install fzf
brew install bat                        # sub for cat
brew install eza                        # sub for ls
brew install htop                       # sub for top
brew install procs                      # sub for ps
brew install ripgrep                    # sub for grep
brew install tealdeer
brew install fastfetch

brew install jq
brew install yq
brew install libpq                      # postgresql tools
brew install pgcli
brew install wakatime-cli

# docker family
brew install k3d
brew install k9s
brew install kubectx
brew install kubectl-ai
brew install lazydocker
brew install kubernetes-cli

# git family
brew install gh
brew install git
brew install lazygit
brew install git-delta
brew install arl/arl/gitmux
brew install clementtsang/bottom/bottom

# pl specific
brew install uv
brew install llvm
brew install rustup
brew install fnm                        # node version manager
brew install npm
brew install pnpm
brew install oven-sh/bun/bun

brew install cowsay
brew install fortune
brew install lolcat

# refer to :checkhealth snacks
brew install gs                         # for pdf rendering
brew install imagemagick                # for image rendering

brew install --cask rar
brew install --cask emacs
brew install --cask slack
brew install --cask zotero
brew install --cask alfred
brew install --cask ghostty
brew install --cask spotify
brew install --cask postman
brew install --cask zen                 # browser in firefox
brew install --cask firefox             # you should install it anyhow
brew install --cask obsidian
brew install --cask orbstack
brew install --cask telegram
brew install --cask wireshark
brew install --cask alacritty           # alacritty for hardcore dev
brew install --cask visual-studio-code
brew install --cask karabiner-elements
brew install --cask espanso/espanso/espanso
brew install --cask nikitabobko/tap/aerospace

# AstroNvim
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim

# tpm
# PS: follow the official tutorial to init
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

fish
# fisher
brew install fisher
fisher install jorgebucaran/fisher
fisher install edc/bass franciscolourenco/done
# add path
fish_add_path /usr/local/go/bin
fish_add_path /opt/homebrew/opt/llvm/bin
