# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list '' 'r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/addison/.zshrc'

zstyle ':completion:*' list-colors ''


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

# precmd() {
# 	LEFT="[$(collapse_pwd)]"
# 	RIGHT=$(vcs_info_wrapper)
#   	RIGHTWIDTH=$(($COLUMNS-${#LEFT}))
#   	print '\n'$LEFT${(l:$RIGHTWIDTH:)RIGHT}
# }

precmd(){
	print''
}

# set VIMODE according to the current mode (default “[i]”)
function zle-line-init zle-keymap-select() {
	#PROMPT="[${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}] "
	if [ "$TERM" = "st-256color" ]; then
		if [ $KEYMAP = vicmd ]; then
		    # the command mode for vi
		    echo -ne "\e[2 q"
		else
		    # the insert mode for vi
		    echo -ne "\e[4 q"
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
RPS1=$'$(vcs_info_wrapper)'
PS2="╰─▶ "
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

# file extensions
alias -s py='python'
alias -s txt='nvim'
alias -s md='nvim'
alias -s mp3='vlc'
alias -s mp4='vlc'
alias -s wav='vlc'
alias -s png='meh'
alias -s jpg='meh'

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

# defined aliases }}}

# defined functions: {{{

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

# PROMPT="%d \$ "
# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/base16-monokai.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

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

# ls rebinds
la() {
	ls -a
}

ll() {
	ls -l
}

lal() {
	ls -al
}

mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# nvim for man
export MANPAGER="nvim -c 'set ft=man' -"

# alias ranger='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"; rm ~/rangerdir'

#vim Ctrlz keybinging
_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

export PATH=$HOME/.local/bin:${PATH}
export PATH=$HOME/.gem/ruby/2.4.0/bin:${PATH}
# export PYTHONPATH=/usr/lib/python2.7/site-packages:${PYTHONPATH}

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
