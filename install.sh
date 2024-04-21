# Do the following two line first
# cd ~ && mkdir Repository && cd Repository
# git clone git@github.com:humbornjo/dotfiles.git dotfiles

# Install font
git clone https://github.com/humbornjo/SF-Mono-Nerd-Font
cd SF-Mono-Nerd-Font && cp ./SF* $USER/Library/Fonts/

# terminal & shell
brew install fish
brew install thefuck    # fuck is good
brew install tmux
brew install starship
brew install zoxide

# substitute
brew install fd
brew install bat        # sub for cat
brew install exa        # sub for ls
brew install htop       # sub for top
brew install tree
brew install ripgrep    # sub for grep

brew install fzf
brew install gh
brew install git
brew install git-delta
brew install lazygit    # easy git
brew install lazydocker # easy docker
brew install yazi       # terminal file manager
brew install fnm        # node version manager
brew install lsd
brew install pyenv
brew install mackup
brew install fastfetch
brew install neovim
brew install pgcli
brew install tealdeer
brew install wakatime-cli

brew tap clementtsang/bottom
brew install bottom

brew tap arl/arl
brew install gitmux

# Lore
brew install cowsay
brew install fortune
brew install lolcat


# For configuring these two, pls refer to Doctor. Google
brew install koekeishiya/formulae/skhd
brew install koekeishiya/formulae/yabai

# UI app
brew install --cask alacritty
brew install --cask alfred
brew install --cask obsidian 
brew install --cask spacelauncher 
brew install --cask karabiner-elements
brew install --cask spotify
brew install --cask wireshark
brew install --cask vivaldi
brew install --cask firefox     # you should install it anyhow

# From github
#-AstroNvim
mv ~/.config/nvim ~/.config/nvim.bak

mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim

#-fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install franciscolourenco/done edc/bass

#-tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf



