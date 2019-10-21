#!/bin/zsh
# ========== Esta parte con ZSH
cd ~/.oh-my-zsh/custom/plugins

# Add the syntax highlighting
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

# Change the .zshrc file for applying the plugins
# Find the line number of the plugins line
export line_number=$(grep -nr "plugins=(git" ~/.zshrc | cut -d : -f 1)
# Replace this line.
sed -i "$(echo $line_number)s/.*/plugins=(git bundler brew fasd zeus gem rails ruby npm node nanoc history-substring-search zsh-syntax-highlighting)/" ~/.zshrc

# Fasd configuration
echo 'eval "$(fasd --init auto)"' >> ~/.zshrc

# Install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo "# Rbenv configuration" >> ~/.zshrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
# Rbenv build
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo "# Python configuration" >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# Install nodenv
git clone https://github.com/nodenv/nodenv.git ~/.nodenv
cd ~/.nodenv && src/configure && make -C src
echo "# Rbenv configuration" >> ~/.zshrc
echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(nodenv init -)"' >> ~/.zshrc
# Add nodenv binaries
echo "[[ \$(nodenv version) =~ '([[:digit:]]+\.)+[[:digit:]]+' ]]; export current_version=\$MATCH" >> ~/.zshrc
echo 'export PATH="$HOME/.nodenv/versions/$current_version/bin:$PATH"' >> ~/.zshrc
# Nodenv build
mkdir -p "$(nodenv root)"/plugins
git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build

# Install pgvm
curl -s -L https://raw.github.com/guedes/pgvm/master/bin/pgvm-self-install | bash
# Postgres manager conf
echo "# Pgvm configuration" >> ~/.zshrc
echo 'source $HOME/.pgvm/pgvm_env' >> ~/.zshrc

# Install phantomenv
git clone -b v0.0.10 https://github.com/boxen/phantomenv.git ~/.phantomenv
echo "#Phantomenv configuration" >> ~/.zshrc
echo 'export PATH="$HOME/.phantomenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(phantomenv init -)"' >> ~/.zshrc



# Octave
# Install required and suggested packages
sudo apt-get install -y gfortran libpcre3-dev libblas-dev liblapack-dev libreadline-dev
sudo apt-get install -y libqhull-dev libhdf5-serial-dev libfftw3-dev libglpk-dev libcurl4-gnutls-dev libsndfile1-dev portaudio19-dev libgraphicsmagick++1-dev libgl1-mesa-dev libgl1-mesa-dev libfreetype6-dev 	libfontconfig1-dev 	libosmesa6-dev 	libgl2ps-dev libqt4-dev libqtcore4  libqtwebkit4 libqt4-network libqtgui4 libqt4-opengl-dev libfltk1.3-dev
sudo apt-get install -y libqrupdate-dev	libsuitesparse-dev libarpack2-dev gnuplot-x11
sudo apt-get install -y libxft-dev libqscintilla2-dev