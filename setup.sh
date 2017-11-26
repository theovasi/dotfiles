#!/bin/bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update -y
sudo apt-get install software-properties-common python-software-properties i3 i3blocks neovim git feh rofi scrot imagemagick i3lock dbus python-dev python-pip python3-dev python3-pip cmake make g++ xorg-dev libqt4-dev libcurl4-openssl-dev libavahi-compat-libdnssd-dev libssl-dev libx11-dev build-essential cmake zsh spotify-client compton synergy flake8 -y
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

pip install setuptools autopep8
pip install --upgrade neovim
pip2 install --upgrade neovim
pip3 install --upgrade neovim

mkdir ~/.fonts ~/.scripts

cp -rf i3 nvim compton.conf ~/.config/
cp fonts/* ~/.fonts
cp scripts/i3lock.sh ~/.scripts
cp .bashrc .zshrc .oh-my-zsh .Xresources ~/ 
