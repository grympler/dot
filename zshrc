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

antigen theme romkatv/powerlevel10k

export PATH=$HOME/opt/bin:$PATH

# Color handling for both within tmux and outside tmux
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

export PAGER="less"
export EDITOR="vim"

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

# If needed, completions file must be put in $ZSH_CUSTOM_ROOT_DIR/completions directory
fpath=($ZSH_CUSTOM_ROOT_DIR/completions $fpath)

if [ -d $ZSH_CUSTOM_ROOT_DIR/custom ]; then
    source $ZSH_CUSTOM_ROOT_DIR/custom/*
else
    print "404: Custom conf dir not found $ZSH_CUSTOM_ROOT_DIR not found."
fi

# Tell Antigen that you're done.
antigen apply
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
