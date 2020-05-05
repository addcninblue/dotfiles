# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list '' 'r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/addison/.zshrc'

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select


autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

bindkey jk vi-cmd-mode

#export KEYTIMEOUT=1 #for vimodes

autoload -Uz colors && colors

#git
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%b'
zstyle ':vcs_info:*' formats       \
    '%b'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "${vcs_info_msg_0_}"
  fi
}

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

precmd(){
	print''
}

# set VIMODE according to the current mode (default “[i]”)
function zle-line-init zle-keymap-select() {
	#PROMPT="[${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}] "
	if [ "$TERM" = "st-256color" ] | [ "$TERM" = "xterm-256color" ]; then
		if [ $KEYMAP = vicmd ]; then
		    # the command mode for vi
		    echo -ne "\e[2 q"
		else
		    # the insert mode for vi
		    echo -ne "\e[5 q"
		fi
	    fi
	zle reset-prompt
}

zle -N zle-keymap-select
zle -N zle-line-init

function ssh_connection() {
    if [[ -n $SSH_CONNECTION ]]; then
        echo "@%m"
    else
        echo ""
    fi
}

function ranger_prompt() {
  if [[ $RANGER_LEVEL -eq 1 ]]; then
    echo "[ranger]"
  elif [[ $RANGER_LEVEL -gt 1 ]]; then
    echo "[ranger $RANGER_LEVEL]"
  fi
}

function zsh_prompt() {
    username="%n$(ssh_connection)"
    hostname="%{$fg[blue]%}%d%{$reset_color%}"
    backgrounded="%(1j.[%j].)"
    nextrow="\n╰─▶ "
    echo "╭─[$username in $hostname] $(ranger_prompt) $backgrounded $nextrow"
}

PS1="$(zsh_prompt)"
# RPS1=$'$(vcs_info_wrapper)'
PS2="╰─▶ "

## Right prompt with Git and clock.
## (Adapted from code found at <https://gist.github.com/joshdick/4415470>.)
## (Adapted from code found at <https://github.com/ejpcmac/config_files/blob/bc9ee4e7363e4e0ca97f4addbdd9370b83048d3c/zsh/themes/bazik.zsh-theme#L56>)
# Modify the colors and symbols in these variables as desired.
# GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
# GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_PREFIX="["
GIT_PROMPT_SUFFIX="]"
GIT_PROMPT_AHEAD="%{$fg[red]%}↑NUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}↓NUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[red]%}·%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[yellow]%}·%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%}·%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropirate for Git remote states
parse_git_remote_state() {
    # Compose this value via multiple conditional appends.
    local GIT_STATE=""

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi

    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi

    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

# Show different symbols as appropriate for various Git repository states
parse_git_state() {
    # Compose this value via multiple conditional appends.
    local GIT_STATE=""

    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi

    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
    fi

    if ! git diff --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
    fi

    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

# If inside a Git repository, print its branch and state
git_prompt_string() {
    local git_where="$(parse_git_branch)"
    [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$(parse_git_remote_state)$GIT_PROMPT_PREFIX${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}

clock() {
    echo "[%{$fg[blue]%}%D{%H:%M:%S}%{$reset_color%}]"
}

# Set the right-hand prompt
RPS1='$(git_prompt_string)$(clock)'
# add put this here

export TERM='xterm-256color'

# defined aliases {{{
alias ls='ls --color=auto'
alias r='ranger'
alias v='nvim'
alias s='ssh'
alias proxy='ssh rpi -D 8080'
alias g='git'
alias q='exit'
alias vmore="nvim -u ~/.vim/ftplugin/more.vim -"
alias ..='cd ..'
alias p='python'
alias sw='sudo wifi-menu'
alias wf='sudo systemctl restart netctl-auto@wlan0.service' # wifi fix
alias share='shellshare --room addison --password addison'
alias vim='nvim'
alias whatismyip='printf "global: " && dig +short myip.opendns.com @resolver1.opendns.com'

# file extensions
alias -s py='python'
alias -s txt='nvim'
alias -s md='nvim'
alias -s mp3='vlc'
alias -s mp4='vlc'
alias -s wav='vlc'
alias -s png='meh'
alias -s jpg='meh'
alias -s pdf='zathura'
alias -s html='garcon-url-handler'

alias c='gcalcli'
alias cc='gcalcli calw'
alias cw='gcalcli calw'
alias cm='gcalcli calm'
quick() {
	gcalcli quick "$1" && gcalcli calw
}

# git
alias ga='git add -i'
alias cdg='cd $(git rev-parse --show-toplevel)'
alias gd='git diff'
alias gs='git status'

# temp files
alias vtt='nvim ~/tmp/tmp$RANDOM.txt'
alias vtp='nvim ~/tmp/tmp$RANDOM.py'
alias vtj='nvim ~/tmp/tmp$RANDOM.java'
alias vt='nvim ~/tmp/tmp$RANDOM'
alias vtm='nvim ~/tmp/tmp$RANDOM.md'
alias vts='nvim ~/tmp/tmp$RANDOM.scm'
alias vtsq='nvim ~/tmp/tmp$RANDOM.sql'
alias vth='nvim ~/tmp/tmp$RANDOM.hs'

alias pacaur='echo "use trizen"'

# dotfiles
alias editi3='nvim ~/.config/i3/config'
alias editpolybar='nvim ~/.config/polybar/config'
alias editmaid='nvim ~/dotfiles/maid/rules.rb'

# alias j="jupyter notebook --ip $(ip addr show eth0 | grep -Po 'inet \K[\d.]+')"
alias j="jupyter notebook"

# defined aliases }}}

# defined functions: {{{

copy() {
       readlink -f $1 | xclip -selection clipboard
}

weather() {
       curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-San Jose}"
}

gcp() {
	if [ "$1" = 'sync' ]; then
		unison -auto -batch 'Google Compute Platform'
	elif [ "$1" = 'watch' ]; then
		while inotifywait -e modify -e delete .; do unison -auto -batch 'Google Compute Platform'; done
	else
		ssh gcp
	fi
}

# test driven development
tdd() {
	# while inotifywait -e close_write $1; do $2; done
	while inotifywait -e modify .; do python test.py -f $1 -q $2; done
}

# timer
countdown() {
	secs=$1
	while [ $secs -gt 0 ]; do
		echo -ne " Seconds left: $secs\033[0K\r"
		sleep 1
		: $((secs--))
	done
	echo -ne "\033[0K\r" # clear line
}

# temp file most recent opener "vim temp open"
vto () {
	if [[ -n $1 ]]; then
		cd $HOME/tmp && nvim $(ls -altr *.$1 | awk '$9 ~ /^[^.]/ {print $9}' | tail -n1)
	else
		cd $HOME/tmp && nvim $(ls -altr | awk '$9 ~ /^[^.]/ {print $9}' | tail -n1)
	fi
}

gch() {
	git checkout "$1"
}

gc() {
	git commit -m "$1"
}

t() {
	if [ -e tmux-start ]
	then
		./tmux-start
	else
		tmux
	fi
}

youtube() {
	youtube-dl "$1" --extract-audio --audio-format mp3
}

agenda() {
	cd ~/stuff/agenda && \
	pdfunite printable.pdf lines2.pdf agenda.pdf && \
	pdfnup --nup 1x2 --no-landscape agenda.pdf --papersize '{8.5in,11in}' && \
	lp agenda-nup.pdf
	
}

# defined functions }}}

magic-enter () {
        if [[ -z $BUFFER ]]
        then
		BUFFER=$history[$((HISTCMD-1))]
		zle accept-line
        else
                zle accept-line
        fi
}
zle -N magic-enter
bindkey "^M" magic-enter

export VISUAL=nvim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# FZF STUFF

# fzf to file location
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# vim open file
vimf() {
   local file
   file=$(fzf +m -q "") && nvim "$file"
}

# zathura file
zaf() {
	local file
	file=$(fzf +m -q "$1.pdf") && zathura "$file"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# END FZF STUFF

# nvim for man
export MANPAGER="nvim -c 'set ft=man' -"

alias ranger='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"; rm ~/rangerdir'

# set shell for tmux
export SHELL=$(which zsh)

#vim Ctrlz keybinging
_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

export PATH=$HOME/.local/bin:${PATH}
export PATH=$HOME/.gem/ruby/2.4.0/bin:${PATH}
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/snap/bin
# export PATH=$PATH:$(go env GOPATH)/bin
# export GOPATH=$HOME/go
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
# export PYTHONPATH=/usr/lib/python2.7/site-packages:${PYTHONPATH}

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

export DOCKER_HOST=ssh://server

bindkey    "^[[H"    beginning-of-line
bindkey    "^[[F"    end-of-line
bindkey    "^[[3~"   delete-char
bindkey    "^[[7~"   beginning-of-line
bindkey    "^[[8~"   end-of-line
bindkey    "^[[P"    delete-char
bindkey    "^?"      backward-delete-char
bindkey    "^[[4~"   end-of-line


# stty -ixon
[[ $- == *i* ]] && stty -ixon

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. ~/dotfiles/tools/z.sh

if [ "$TERM" = "linux" ]; then
echo -en "\e]P0073642" #black
echo -en "\e]P1dc322f" #darkgrey
echo -en "\e]P2859900" #darkred
echo -en "\e]P3b58900" #red
echo -en "\e]P4268bd2" #darkgreen
echo -en "\e]P5d33682" #green
echo -en "\e]P62aa198" #brown
echo -en "\e]P7eee8d5" #yellow
echo -en "\e]P8002b36" #darkblue
echo -en "\e]P9cb4b16" #blue
echo -en "\e]PA586e75" #darkmagenta
echo -en "\e]PB657b83" #magenta
echo -en "\e]PC839496" #darkcyan
echo -en "\e]PD6c71c4" #cyan
echo -en "\e]PE93a1a1" #lightgrey
echo -en "\e]PFfdf6e3" #white
clear #for background artifacting
fi

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [ -f ~/.zsh_private_variables ]; then
	source ~/.zsh_private_variables
fi

if [ ! -f ~/local ]; then
	ssh server && exit
fi
