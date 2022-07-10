#!/bin/zsh
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "Installing oh my zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins

# Add the syntax highlighting
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

# Change the .zshrc file for applying the plugins
# Find the line number of the plugins line
export line_number=$(grep -nr "plugins=(git" ~/.zshrc | cut -d : -f 1)
# Replace this line.
sed -i "$(echo $line_number)s/.*/plugins=(git bundler docker docker-compose fasd gem rails ruby npm node history-substring-search zsh-syntax-highlighting)/" ~/.zshrc

# Fasd configuration
echo 'eval "$(fasd --init auto)"' >> ~/.zshrc

echo "${GREEN}Zsh plugins installed successfully!${NC}"

vared -p 'Would you like to install rbenv (Simple Ruby version manager)? [yes/no] ' -c install_rbenv

if [[ "$install_rbenv" = ""  || "$install_rbenv" = "yes" || "$install_rbenv" = "y" ]]; then
    # Installing packages required for Ruby installation
    echo "Installing required packages for Ruby"
    sudo apt install -y zlib1g-dev libpq-dev
    # Install rbenv
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src
    echo "# Rbenv configuration" >> ~/.zshrc
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    # Rbenv build
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

vared -p 'Would you like to install pyenv (Simple Python version manager)? [yes/no] ' -c install_pyenv

if [[ "$install_pyenv" = ""  || "$install_pyenv" = "yes" || "$install_pyenv" = "y" ]]; then
    # Install pyenv
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    echo "# Python configuration" >> ~/.zshrc
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
fi

vared -p 'Would you like to install nodenv (Simple Node version manager)? [yes/no] ' -c install_nodenv

if [[ "$install_nodenv" = ""  || "$install_nodenv" = "yes" || "$install_nodenv" = "y" ]]; then
    # Install nodenv
    git clone https://github.com/nodenv/nodenv.git ~/.nodenv
    cd ~/.nodenv && src/configure && make -C src
    echo "# Nodenv configuration" >> ~/.zshrc
    echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(nodenv init -)"' >> ~/.zshrc
    # Add nodenv binaries
    echo "[[ \$(nodenv version) =~ '([[:digit:]]+\.)+[[:digit:]]+' ]]; export current_version=\$MATCH" >> ~/.zshrc
    echo 'export PATH="$HOME/.nodenv/versions/$current_version/bin:$PATH"' >> ~/.zshrc
    # Nodenv build
    mkdir -p ~/.nodenv/plugins
    git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
fi


vared -p 'Would you like to install postgresql? [yes/no] ' -c install_postgres

if [[ "$install_postgres" = ""  || "$install_postgres" = "yes" || "$install_postgres" = "y" ]]; then
    # Install postgres
    sudo apt -y install postgresql postgresql-contrib pgcli
fi

vared -p 'Would you like to install docker and docker compose? [yes/no] ' -c install_docker

if [[ "$install_docker" = ""  || "$install_docker" = "yes" || "$install_docker" = "y" ]]; then
    sudo apt install -y ca-certificates curl gnupg lsb-release
    
    # Add docker official GPG key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    # set up repository 
    echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

echo "${GREEN}All packages were installed successfully! Please, close your session and reopen it for the terminal changes to take place${NC}"

# Octave
# Install required and suggested packages
# sudo apt install -y gfortran libpcre3-dev libblas-dev liblapack-dev libreadline-dev
# sudo apt install -y libqhull-dev libhdf5-serial-dev libfftw3-dev libglpk-dev libcurl4-gnutls-dev libsndfile1-dev portaudio19-dev libgraphicsmagick++1-dev libgl1-mesa-dev libgl1-mesa-dev libfreetype6-dev 	libfontconfig1-dev 	libosmesa6-dev 	libgl2ps-dev libqt4-dev libqtcore4  libqtwebkit4 libqt4-network libqtgui4 libqt4-opengl-dev libfltk1.3-dev
# sudo apt install -y libqrupdate-dev	libsuitesparse-dev libarpack2-dev gnuplot-x11
# sudo apt install -y libxft-dev libqscintilla2-dev
