# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list '' 'r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/addison/.zshrc'

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

RPROMPT=$'$(vcs_info_wrapper)'
PROMPT="╭─[%n$(ssh_connection) in %{$fg[blue]%}%d%{$reset_color%}] %(1j.[%j].)
╰─▶ "
# add put this here

export TERM='xterm-256color'

# defined aliases {{{
alias ls='ls --color=auto'
alias r='ranger'
alias v='vim'
alias s='ssh'
alias proxy='ssh rpi -D 8080'
alias g='git'
alias q='exit'
alias vmore="vim -u ~/.vim/ftplugin/more.vim -"
alias ..='cd ..'
alias p='python'
alias sw='sudo wifi-menu'
alias wf='sudo systemctl restart netctl-auto@wlan0.service' # wifi fix
alias share='shellshare --room addison --password addison'

# file extensions
alias -s py='python'
alias -s txt='vim'
alias -s md='vim'
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
alias vtt='vim ~/tmp/tmp$RANDOM.txt'
alias vtp='vim ~/tmp/tmp$RANDOM.py'
alias vtj='vim ~/tmp/tmp$RANDOM.java'
alias vt='vim ~/tmp/tmp$RANDOM'
alias vtm='vim ~/tmp/tmp$RANDOM.md'
alias vts='vim ~/tmp/tmp$RANDOM.scm'
alias vtsq='vim ~/tmp/tmp$RANDOM.sql'
alias vth='vim ~/tmp/tmp$RANDOM.hs'

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

testing() {
	echo $(pwd)
	# echo "$@"
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
		cd $HOME/tmp && vim $(ls -altr *.$1 | awk '$9 ~ /^[^.]/ {print $9}' | tail -n1)
	else
		cd $HOME/tmp && vim $(ls -altr | awk '$9 ~ /^[^.]/ {print $9}' | tail -n1)
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

export VISUAL=vim
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
   file=$(fzf +m -q "") && vim "$file"
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

# vim for man
export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"

# codi.vim wrapper
codi() {
  vim $2 -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=8 ctermfg=8 |\
    hi NonText ctermfg=8 |\
    cnoremap q q! |\
    Codi ${1:-python}"
}

alias ranger='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"; rm ~/rangerdir'

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

# zsh syntax highlighting
source /home/addison/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /home/addison/.zsh/zsh-autosuggestions-master/zsh-autosuggestions.zsh
: <<'END'
# zplug
source ~/.zplug/init.zsh
zplug "jocelynmallon/zshmarks"
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load 

