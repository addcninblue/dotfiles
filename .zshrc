# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
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

RPROMPT=$'$(vcs_info_wrapper)'
PROMPT="╭─[%n in %{$fg[blue]%}%d%{$reset_color%}]
╰─▶ "
#add put this here
alias ls='ls --color=auto'
# PROMPT="%d \$ "
# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/base16-monokai.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

#FZF STUFF

# fzf to file location
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
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

#END FZF STUFF

bindkey    "^[[H"    beginning-of-line
bindkey    "^[[F"    end-of-line
bindkey    "^[[3~"   delete-char
bindkey    "^[[7~"   beginning-of-line
bindkey    "^[[8~"   end-of-line
bindkey    "^[[P"    delete-char
bindkey    "^[[4~"   end-of-line

stty -ixon

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
