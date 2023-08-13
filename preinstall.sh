#/bin/bash

cd ~ && mkdir Repository && cd Repository
git clone git@github.com:humbornjo/dotfiles.git dotfiles

# Routine features
brew install bat
brew install fd
brew install fish
brew install fzf
brew install gh
brew install git
brew install git-delta
brew install lazydocker
brew install lazygit
brew install nnn
brew install lsd
brew install tree
brew install htop
brew install pyenv
brew install mackup
brew install neofetch
brew install neovim
brew install pgcli
brew install ripgrep
brew install starship
brew install tealdeer
brew install tmux
brew install wakatime-cli
brew install zoxide

brew tap clementtsang/bottom
brew install bottom

brew tap arl/arl
brew install gitmux

# Lore
brew install cowsay
brew install fortune
brew install lolcat


# For configuring these two, pls refer to Doctor. Google
brew install skhd
brew install yabai

# UI app
brew install --cask alacritty
brew install --cask alfred
brew install --cask obsidian 
brew install --cask spacelauncher 
brew install --cask karabiner-elements

# From github
#-AstroNvim
mkdir -p ~/.config/nvim
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim

#-fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install FabioAntunes/fish-nvm franciscolourenco/done

#-nvm
mkdir ~/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

#-tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf



