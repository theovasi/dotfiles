#!/bin/bash
# Install i3-gaps
sudo apt-get update -y
sudo apt install libxcb-xrm-dev libxcb-shape0-dev libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake i3blocks feh rofi curl zsh

sudo add-apt-repository -y ppa:kgilmer/speed-ricer
sudo apt install i3-gaps compton

sudo apt-get update -y &&
sudo apt install git neovim
sudo apt-get install zsh i3 i3blocks neovim git feh rofi scrot imagemagick i3lock dbus python-dev python-pip python3-dev python3-pip cmake make g++ xorg-dev libqt4-dev libcurl4-openssl-dev libavahi-compat-libdnssd-dev libssl-dev libx11-dev build-essential cmake snap compton synergy flake8 rxvt-unicode-256color tmux -y &&
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" &&

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell &&


pip install setuptools autopep8 &&
pip install --upgrade neovim &&
pip install --upgrade pynvim &&
pip3 install --upgrade neovim &&
pip3 install --upgrade pynvim &&

mkdir ~/.fonts ~/.scripts &&

#cp -rf i3 nvim compton.conf ~/.config/ &&
cp fonts/* ~/.fonts &&
cp scripts/i3lock.sh ~/.scripts &&
cp .zshrc .Xresources .tmux.conf ~/ && 
xrdb ~/.Xresources
