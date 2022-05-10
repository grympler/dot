ZSH_CUSTOM_ROOT_DIR="$HOME/.oh-my-zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# To call firt as it might block pip and virtualenv if not.
antigen bundle mattberther/zsh-pyenv

# Bundles fro/ the default repo (robbyrussell's oh-my-zsh).
antigen bundle command-not-found
antigen bundle docker
antigen bundle git
antigen bundle git-extra
antigen bundle lein
antigen bundle pip
antigen bundle virtualenv

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

# user made bundle.
# https://github.com/wfxr/forgit
antigen bundle 'wfxr/forgit'
antigen theme romkatv/powerlevel10k

export PATH=$HOME/opt/bin:$PATH

# Color handling for both within tmux and outside tmux
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

export PAGER="less"
export EDITOR="vim"

# Deno for vim
export DENO_INSTALL="/home/olivier/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# ALIASES
alias clean="find . \( -name \"*~\" -o -name \".*~\" \) -delete"
alias l="ls -ltra"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  fi
export PYENV_VIRTUALENVWRAPPER_PREFER_PYENV="true"
export WORKON_HOME=$HOME/.virtualenvs
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper_lazy

# Custom files

## If needed, completions file must be put in $ZSH_CUSTOM_ROOT_DIR/completions directory
fpath=($ZSH_CUSTOM_ROOT_DIR/completions $fpath)
# FIXME: not working
fpath=($ZSH_CUSTOM_ROOT_DIR/functions $fpath)

## Docker
docker_rm_all_images () {docker rmi -f $(docker images -a -q)}
docker_rm_all_containers () {docker rm -vf $(docker ps -a -q)}
docker_stop_all () {docker stop $(docker container ls -q)}

# Misc func
replace () {
    if [ $# -ne 4 ]; then
        echo "Usage: replace <location to search> <replace> <replace_by> <file pattern>"
        exit 0
    fi
    find "$1" -name "$4" -type f -print0 | xargs -0 sed -i "s/$2/$3/g"
}

# TODO: Fix me and load from external config file
## Functions
#for file in $ZSH_CUSTOM_ROOT_DIR/functions/*; autoload -Uz  $file

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fv() {
    IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
    print -s "vim $files"
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
    IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    print -s "xdg-open "$file""
    if [ -n "$file" ]; then
        [ "$key" = ctrl-o ] && xdg-open "$file" || ${EDITOR:-vim} "$file"
    fi
}

# FIXME: Not working as intented
#fd - cd to selected directory from home dir
#fhd() {
    #local dir
    #dir=$(find ${1:-.} -path '~/*' -prune \
        #-o -type d -print 2> /dev/null | fzf +m) &&
        #cd "$dir"
#}

# fda - including hidden directories
fda() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && print -s "cd $dir" && cd "$dir"
}

#fd - cd to selected directory
fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) && print -s "cd $dir" && cd "$dir"
}

fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --height "50%" | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# Zettle-wiki
zet() {
  vim "+Zet $*"
}

export DEEPOMATIC_CONFIG_USER_CREDENTIALS_DIR=

if [ -d $ZSH_CUSTOM_ROOT_DIR/custom ]; then
    source $ZSH_CUSTOM_ROOT_DIR/custom/*
else
    print "404: Custom conf dir not found $ZSH_CUSTOM_ROOT_DIR not found."
fi

# Tell Antigen that you're done.
antigen apply
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /home/olivier/.dmake/config.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
