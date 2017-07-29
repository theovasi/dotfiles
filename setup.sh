#!/bin/bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update

sudo apt-get install software-properties-common
sudo apt-get install python-software-properties
sudo apt-get install i3 neovim git feh rofi scrot imagemagick i3lock dbus
sudo apt-get install python-dev python-pip python3-dev python3-pip
sudo apt-get install cmake make g++ xorg-dev libqt4-dev libcurl4-openssl-dev libavahi-compat-libdnssd-dev libssl-dev libx11-dev
sudo apt-get install build-essential cmake
sudo apt-get install python-dev python3-dev

pip install setuptools
pip install --upgrade neovim
pip2 install --upgrade neovim
pip3 install --upgrade neovim

mkdir ~/.fonts ~/.scripts

cp -rf i3 ~/.config/
cp /fonts/* ~/.fonts
cp .Xresources ~/ 
cp -rf nvim/ ~/.config/
cp i3lock.sh ~/.scripts

cd ~/.config/nvim/bundle/
git clone https://github.com/Valloric/YouCompleteMe
cd YouCompleteMe/
./install.py



