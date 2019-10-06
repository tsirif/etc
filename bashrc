# etc/bashrc
#
# Some generally good configurations for our setup in empiricus

# If not interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

## Source global definitions
# if [ -f /etc/bashrc ]; then
#   . /etc/bashrc
# fi

################################################################################
#                                   Aliases                                    #
################################################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias tar-gz='tar czf'
alias tar-bz2='tar cjf'

alias untar-gz='tar xzf'
alias untar-bz2='tar xjf'

alias df='df -kh'
alias du='du -kh'

################################################################################
#                            Environment Settings                              #
################################################################################

# Prepend CUDA paths
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export C_INCLUDE_PATH=/usr/local/cuda/include${C_INCLUDE_PATH:+:${C_INCLUDE_PATH}}

# conda initialize
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/case/local/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/case/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/case/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/case/local/anaconda3/bin${PATH:+:${PATH}}"
    fi
fi
unset __conda_setup

################################################################################
#                              Terminal Settings                               #
################################################################################

## General terminal settings
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# set a fancy prompt (non-color, unless we know we "want" color)
export TERM='xterm-256color'
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Git highlighting script and prompt
if [ -f "/home/case/etc/bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=0
    # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
    # GIT_PROMPT_IGNORE_SUBMODULES=1 # uncomment to avoid searching for changed files in submodules
    # GIT_PROMPT_WITH_VIRTUAL_ENV=0 # uncomment to avoid setting virtual environment infos for node/python/conda environments
    GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
    GIT_PROMPT_SHOW_UNTRACKED_FILES=normal # can be no, normal or all; determines counting of untracked files
    # GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files
    # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

    ## as last entry source the gitprompt script
    # GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
    # GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
    # GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
    GIT_PROMPT_THEME=Custom
    GIT_PROMPT_THEME_FILE="/home/case/etc/git-prompt-colors.sh"
    source "/home/case/etc/bash-git-prompt/gitprompt.sh"
fi

# Editors
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export SYSTEMD_PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Bash Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash-completion ]; then
    . /usr/share/bash-completion/bash-completion
  elif [ -f /etc/bash-completion ]; then
    . /etc/bash_completion
  fi
fi
