#!/bin/bash
sudo apt-get update -y
sudo apt-get install zsh i3 i3blocks neovim git feh rofi scrot imagemagick i3lock dbus python-dev python-pip python3-dev python3-pip cmake make g++ xorg-dev libqt4-dev libcurl4-openssl-dev libavahi-compat-libdnssd-dev libssl-dev libx11-dev build-essential cmake snap compton synergy flake8 -y
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell


pip install setuptools autopep8
pip install --upgrade neovim
pip3 install --upgrade neovim

mkdir ~/.fonts ~/.scripts

#cp -rf i3 nvim compton.conf ~/.config/
cp fonts/* ~/.fonts
cp scripts/i3lock.sh ~/.scripts
cp .zshrc .Xresources ~/ 
xrdb ~/.Xresources
