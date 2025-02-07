# Do the following two line first
cd ~ && git clone git@github.com:humbornjo/dotfiles.git

sudo pacman -S gcc clang
sudo pacman -S debugedit fakeroot
sudo pacman -S neovim vim kitty-terminfo 
sudo pacman -S stow fish tmux starship zoxide
sudo pacman -S tree fd bat eza htop procs ripgrep curl unzip wget
sudo pacman -S fzf git lazygit yazi pyenv fastfetch pgcli tealdeer wakatime git-delta bottom
# pacman -S gitmux

# fnm 
curl -fsSL https://fnm.vercel.app/install | bash

# AstroNvim
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
nvim
rm -rf ~/.config

# fisher
sudo pacman -S fisher
fish
fisher install jorgebucaran/fisher edc/bass

# finally, import all the config using stow
cd dotfiles && git switch arch && stow .

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# personal perferences
sudo chown $USER:$USER /usr/local /usr/local/bin
