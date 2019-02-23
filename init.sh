#!/bin/bash

# install the modern workflow tools
brew install zsh tmux neovim/neovim/neovim python3 ag reattach-to-user-namespace
brew tap caskroom/cask
brew cask install iterm2

# install the plugin manager for nvim and python to pull some extensions for nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
python3 -m pip install neovim

# set zsh as the default shell
chsh -s /usr/local/bin/zsh

# finally, remove any existing config for the tools
rm -rf ~/.vim ~/.vimrc ~/.zshrc ~/.tmux ~/.tmux.conf ~/.config/nvim 2> /dev/null

# nvim expects certain directories to be present 
mkdir -p ~/.config ~/.config/nvim

# create symlinks to recognize the tools
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim

# run nvim instead of vim
alias vim="nvim"
