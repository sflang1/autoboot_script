#! /bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Essentials

echo "Installing essential packages for development...."

sudo apt update
sudo apt -y install build-essential curl wget openssl libssl-dev software-properties-common

echo "${GREEN}Packages installed successfully!${NC}"

# Java Development Kit
read -p "Would you like to install the Java Development Kit version 11? [yes/no] " install_jdk

if [ "$install_jdk" = "" ] || [ "$install_jdk" = "yes" ] || [ "$install_jdk" = "y" ]; then
    echo "Installing jdk 11 from https://adoptopenjdk.net ..."
    export CODENAME="$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d = -f 2)"
    sudo apt -y install wget apt-transport-https gnupg
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
    echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb $CODENAME main" | sudo tee /etc/apt/sources.list.d/adoptopenjdk.list
    sudo apt update
    sudo apt -y install adoptopenjdk-11-hotspot

    if [ "$?" = 0 ]; then
        echo "${GREEN}Java Development Kit installed successfully!${NC}"
    else
        echo "${RED}Java Development Kit could not installed${NC}"
    fi
fi

# Installing and configuring git
read -p "Would you like to install and configure Git? [yes/no] " install_git

if [ "$install_git" = "" ] || [ "$install_git" = "yes" ] || [ "$install_git" = "y" ]; then
    echo "Installing git..."
    
    sudo apt -y install git

    if [ "$?" = 0 ]; then
        echo "${GREEN}Git installed successfully!${NC}"

        echo -n "${YELLOW}Do you want to configure the global name and email for Git (it will create an SSH key)? [yes/no] ${NC}"
        read configure_git

        if [ "$configure_git" = "" ] || [ "$configure_git" = "yes" ] || [ "$configure_git" = "y" ]; then
            read -p "Introduce the device user's full name: " name
            git config --global user.name "$name"
            read -p "Introduce the device user's email: " email
            git config --global user.email "$email"
            echo "${GREEN}Global configurations set successfully!${NC}"
            
            echo "Creating and ssh key"
            ssh-keygen -t rsa -b 4096 -C "$email"
            echo "${YELLOW}You can later add your new SSH key to the agent${NC}"
        fi
    else
        echo "${RED}Git could not installed${NC}"
    fi
fi

# Installing ZSH
echo "Installing zsh, a bash interpreter for adding capabilities to bash"
sudo apt -y install zsh
# Install oh-my-zsh, a plugin manager for zsh
curl -L http://install.ohmyz.sh | sh
 
# Set the default shell to zsh
echo "Setting your default interpreter in the terminal to ZSH. Please, introduce your password"
chsh -s /usr/bin/zsh
 
echo "Installing fasd for quickly surfing between folders"
# Installing fasd
cd ~
git clone https://github.com/clvv/fasd.git
cd fasd
sudo make install
echo 'eval "$(fasd --init auto)"' >> ~/.zshrc
