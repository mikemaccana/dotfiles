# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
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
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# https://unix.stackexchange.com/questions/252229/ps1-prompt-to-show-elapsed-time
prompt_command() {
    
    # if [ $? -ne 0 ]; 
    # then 
    #     STATUS_EMOJI="😱"; 
    # else 
    #     STATUS_EMOJI="😎"; 
    # fi

    case $? in

        0)
            STATUS_EMOJI="🤠"; 
        ;;

        130)
            STATUS_EMOJI="🤠"; 
        ;;

        *)
            STATUS_EMOJI="😱"; 
        ;;
    esac

    _PS1_now=$(printf '%(%s)T')

    PS1=$( printf "\n\$STATUS_EMOJI \[\e%02d:%02d:%02d \n\[\033[01;34m\]\w\[\033[00m\]\$ " \
            $((  ( _PS1_now - _PS1_lastcmd ) / 3600))         \
            $(( (( _PS1_now - _PS1_lastcmd ) % 3600) / 60 )) \
            $((  ( _PS1_now - _PS1_lastcmd ) % 60))           \
        )
    _PS1_lastcmd=$_PS1_now
}
PROMPT_COMMAND='prompt_command'
_PS1_lastcmd=$(printf '%(%s)T')


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#########################################

# Maybe not needed anymore? 
# https://github.com/Microsoft/vscode/issues/7556
# export LS_COLORS="ow=01;36;40" 

alias edit='code -g'
alias open='wslview' 

# Include dotfiles in '*'
shopt -s dotglob nullglob

export PATH=$PATH:~/bin

alias gg='git grep -i -n'

function git-destroy-local-changes-and-pull(){
    REMOTE_BRANCH=$1
    git fetch --all
    git reset --hard origin/{$REMOTE_BRANCH}
}

function docker-destroy-containers(){
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
}

export DISABLE_OPENCOLLECTIVE=true
export OPEN_SOURCE_CONTRIBUTOR=true

function i(){
    sudo apt install $*
}

function fuck-concourse(){
    git commit --allow-empty -m "Concourse CI is a terrible piece of software"
}

function lint(){
    npx eslint --fix src/**/*.ts; npx prettier --write 'src/**/*.{ts,js}'; 
}

function lint-file(){
    FILE=$1
    npx eslint --fix "${FILE}"; npx prettier --write "${FILE}"; 
}

# Two space tabs
tabs 2

# Deno
export DENO_INSTALL="/home/mike/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Python 3.8.5
alias python=/usr/bin/python3
alias pip=pip3

cd ~/Code

function git-reto-rename(){
    OLD=$1
    NEW=$2
    mv $NEW $OLD
    git mv $OLD $NEW
}
# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin


function onetest(){
    TESTNAME=$1
    npx jest -t ${TESTNAME}
}

# AWS (humanloop)
. "$HOME/.cargo/env"

alias awsume=". awsume"
