#! /bin/bash

### prepare package_list.txt to be used by paru
package_list=$(awk '{print $1}'  package_list.txt  | sed '/^#/d' | tr '\n' ' ')

# update system and make sure basic packages are installed
sudo pacman -Syyuu --noconfirm
sudo pacman -S --needed base-devel --noconfirm

# install packages for vm environment
echo "install vm needed packages"
sudo pacman -S xf86-input-vmmouse xf86-video-vmware mesa open-vm-tools
sudo systemctl enable vmtoolsd.service
sudo systemctl restart vmtoolsd.service

#### PARU INSTALL ####
echo "installing paru"
git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si

### PACKAGES ####
echo "Installing packages from list"
paru -S $package_list --noconfirm

### OH MY ZSH
echo "installing oh my zsh"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

#### FZF INSTALL ####
echo "installing FUZZ"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

### copying ZSH conf
cp .zshrc $HOME

#### APPLYING TMUX AND VIM CONFIG
echo "copying vimrc and tmux in $HOME "
for file in $( ls -a | egrep 'tmux|vimrc' ); do
  cp $file $HOME
done

### COPYING .CONFING FOLDER
echo "copying .confing folder"
cp -r config $HOME/.config/
