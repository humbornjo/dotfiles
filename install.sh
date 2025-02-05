# Do the following two line first
cd ~ && git clone git@github.com:humbornjo/dotfiles.git


# font 
# pacman -S font-lilex-nerd-font

pacman -S fish
pacman -S tmux
pacman -S starship
pacman -S zoxide

pacman -S tree
pacman -S fd                         # sub for find
pacman -S bat                        # sub for cat
pacman -S eza                        # sub for ls
pacman -S htop                       # sub for top
pacman -S procs                      # sub for ps
pacman -S ripgrep                    # sub for grep

pacman -S fzf
pacman -S git
pacman -S git-delta
pacman -S lazygit                    
pacman -S yazi                       # terminal file manager
pacman -S lsd
pacman -S pyenv
pacman -S mackup
pacman -S fastfetch
pacman -S neovim
pacman -S pgcli
pacman -S tealdeer
pacman -S wakatime

pacman -S kitty-terminfo # https://sw.kovidgoyal.net/kitty/faq/

# brew tap clementtsang/bottom
# pacman -S bottom
#
# brew tap arl/arl
# pacman -S gitmux
#
# pacman -S cowsay
# pacman -S fortune
# pacman -S lolcat
#
#
# pacman -S koekeishiya/formulae/skhd
# pacman -S koekeishiya/formulae/yabai


# pacman -S --cask kitty
# pacman -S --cask alfred
# pacman -S --cask spotify
# pacman -S --cask vivaldi             # browser in chromium
# pacman -S --cask firefox             # you should install it anyhow
# pacman -S --cask obsidian
# pacman -S --cask wireshark
# pacman -S --cask alacritty
# pacman -S --cask spacelauncher
# pacman -S --cask karabiner-elements

# fnm 
curl -fsSL https://fnm.vercel.app/install | bash

# AstroNvim
mv ~/.config/nvim ~/.config/nvim.bak

mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim

# fisher
pacman -S fisher
fisher install jorgebucaran/fisher
fisher install edc/bass   # franciscolourenco/done

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# finally, import all the config using stow
pacman -S stow && cd dotfiles && stow .

