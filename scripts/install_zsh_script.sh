#! /bin/bash

# Essentials

sudo apt-get update
sudo apt-get -y install aptitude

sudo apt-get -y install build-essential curl wget openssl libssl-dev software-properties-common

sudo aptitude -y install python-software-properties

# Java Development Kit
sudo add-apt-repository ppa:linuxuprising/java
sudo aptitude update

sudo aptitude -y install oracle-java11-installer

# Installing and configuring git
sudo aptitude -y install git
read -p "Introduzca el nombre completo del usuario del equipo: " name
git config --global user.name "$name"
read -p "Introduzca el correo electrónico del usuario del equipo: " email
git config --global user.email "$email"

# Installing ZSH
sudo aptitude -y install zsh
# Install oh-my-zsh, a plugin manager for zsh
curl -L http://install.ohmyz.sh | sh

# Set the default shell to zsh
chsh -s /usr/bin/zsh

echo 'Installing fasd'
# Installing fasd
cd ~
git clone https://github.com/clvv/fasd.git
cd fasd
sudo make install
echo 'eval "$(fasd --init auto)"' >> ~/.zshrc
