#! /bin/bash

echo "Installing conf file ... (${PWD})"

git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
curl -L git.io/antigen > ~/antigen.zsh

ln -sf "${PWD}/pylintrc" ~/.pylintrc
ln -sf "${PWD}/zshrc" ~/.zshrc
ln -sf "${PWD}/gitconfig" ~/.gitconfig
ln -sf "${PWD}/gitignore_global" ~/.gitignore_global
ln -sf "${PWD}/tmux.conf" ~/.tmux.conf
ln -sf "${PWD}/ssh_rc" ~/.ssh/rc

echo "Installing vim config ..."

git clone git@github.com:grympler/vim.git ~/.vim
cd ~/.vim && ./install.sh
