#! /bin/bash

ZSH_CUSTOM_ROOT_DIR=~/.oh-my-zsh

echo "Bootstraping..."
mkdir -p ${ZSH_CUSTOM_DIR}/completions
mkdir -p ${ZSH_CUSTOM_DIR}/custom
cat <(echo "ZSH_CUSTOM_ROOT_DIR=$ZSH_CUSTOM_ROOT_DIR") ${PWD}/zshrc

echo "Installing conf file ... (${PWD})"

git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
curl -L git.io/antigen > ~/antigen.zsh

ln -sf "${PWD}/pylintrc" ~/.pylintrc
ln -sf "${PWD}/zshrc" ~/.zshrc
ln -sf "${PWD}/gitconfig" ~/.gitconfig
ln -sf "${PWD}/gitignore_global" ~/.gitignore_global
ln -sf "${PWD}/tmux.conf" ~/.tmux.conf
ln -sf "${PWD}/ssh_rc" ~/.ssh/rc
ln -sf "${PWD}/p10k.zsh" ~/.p10.zsh

echo "Installing python tools ..."
${PWD}/install_python_tools.sh

echo "Installing vim config ..."
git clone git@github.com:grympler/vim.git ~/.vim
cd ~/.vim && ./install.sh
# TODO: note taking app
# prepare https://vimways.org/2019/personal-notetaking-in-vim/
#mkdir ~/wiki

# TODO:
# echo "Configuring terminal ..."
# Use config file for terminal setting
# Add patched font (working with vim statusline)
# https://gist.github.com/reavon/0bbe99150810baa5623e5f601aa93afc
