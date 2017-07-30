#!/bin/bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update -y

sudo apt-get install software-properties-common python-software-properties i3 i3blocks neovim git feh rofi scrot imagemagick i3lock dbus python-dev python-pip python3-dev python3-pip cmake make g++ xorg-dev libqt4-dev libcurl4-openssl-dev libavahi-compat-libdnssd-dev libssl-dev libx11-dev build-essential cmake zsh -y
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

pip install setuptools
pip install --upgrade neovim
pip2 install --upgrade neovim
pip3 install --upgrade neovim

mkdir ~/.fonts ~/.scripts

cp -rf i3 ~/.config/
cp fonts/* ~/.fonts
cp .Xresources ~/ 
cp -rf nvim/ ~/.config/
cp scripts/i3lock.sh ~/.scripts
cp .bashrc ~/
cp .zshrc ~/
cp .oh-my-zsh ~/

gconftool-2 --load gnome-terminal-conf.xml
cd ~/.config/nvim/bundle/
git clone https://github.com/Valloric/YouCompleteMe
cd YouCompleteMe/
git submodule update --init --recursive
./install.py
