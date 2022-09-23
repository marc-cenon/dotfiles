#!/bin/bash

echo "######################"
echo "## I3 & TOOLS SETUP ##"
echo "######################"

# install packages
# git clones repos: dot and walls
# download color scheme cattpuccin
# set up programsO

packages = git vim tmux i3 rofi dunst arandr nitrogen zsh alacritty fonts-powerline imagemagick gnome-tweaks pavucontrol ripgrep neofetch

dependencies = make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl

basic_packages () {
  echo "### install basic packages ###"
  sudo apt install -y $packages
  sudo chsh -s /bin/zsh $USER

  echo "### install oh my zsh ###"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

setup_go () {
  cd $HOME
  wget https://golang.org/dl/go1.19.1linux-amd64.tar.gz
  rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.1.linux-amd64.tar.gz
  echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.zshrc
  source $HOME/.zshrc
}

setup_rust_and_crates () {
  echo "### setup rust ###"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > $HOME/rustup.sh
  sudo chmod +x $HOME/rustup.sh
  $HOME/rustup.sh -y

  echo "### install crates exa - bat - gitui ###"
  cargo install exa
  cargo install fd-find
  cargo install --locked bat
  cargo install gitui
}

setup_python_and_pip () {
  echo "### install pip ###"
  sudo apt install -y python3-pip $dependencies

  echo "### install pyenv - pipenv and python 3.9 ###"
  curl https://pyenv.run | bash
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(pyenv init -)"' >> ~/.zshrc
  exec "$SHELL"
  pyenv install -v 3.9.0
  pyenv global 3.9.0
  pip install --user pipenv
}

setup_lsp () {
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
  sudo apt-get install -y nodejs
}
clone_repos () {
  cd $HOME
  echo "### clone wallpapers repo ###"
  git clone https://github.com/marc-cenon/wallpapers.git

  echo "### clone catppuccin repo for alacritty###"
  cd $HOME
  mkdir $HOME/.config/alacritty
  git clone https://github.com/catppuccin/alacritty.git ~/.config/alacritty/catppuccin

  echo "### clone catppuccin repo for rofi ###"
  cd $HOME
  git clone https://github.com/catppuccin/rofi.git
  bash rofi/basic/install.sh
  
  echo "### clone dots repo###"
  cd $HOME
  git clone https://github.com/marc-cenon/dotfiles.git

  echo "### install gdm-tool ###"
  cd $HOME
  git clone --depth=1 --single-branch https://github.com/realmazharhussain/gdm-tools.git
  cd gdm-tools
  ./install.sh
}

setup_conf () {
  echo "### setup vim and tmux dots ###"
  cp $HOME/dotfiles/.vimrc $HOME/
  cp $HOME/dotfiles/.tmux.conf $HOME/
  cp -r $HOME/dotfiles/i3/* $HOME/.config/

  echo "### SET CHROME CATPPUCCIN THEME ###"
  echo "https://github.com/catppuccin/chrome"

}


### starting all functions ###

basic_packages
setup_go
setup_python_and_pip
setup_rust_and_crates
setup_lsp
clone_repo
setup_conf 
