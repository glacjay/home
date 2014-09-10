# The following lines were added by compinstall
zstyle :compinstall filename '/home/jay/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify histignoredups
bindkey -e
# End of lines configured by zsh-newuser-install

# The following is added by your owner and main user.  Hmmm.

# backspace word by word
autoload -U select-word-style
select-word-style bash

# get the colors
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
    eval C_$color='%{$terminfo[bold]$fg[${color:l}]%}'
    eval C_L_$color='%{$fg[${color:l}]%}'
done
C_OFF="%{$terminfo[sgr0]%}"

# load prompt functions
setopt prompt_subst
autoload -Uz vcs_info
unsetopt transient_rprompt # leave the pwd

# git branch support
zstyle ':vcs_info:*' actionformats \
	'%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
	'%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git hg svn
vcs_info_wrapper() {
	vcs_info
	if [ -n "%vcs_info_msg_0_" ]; then
		echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
	fi
}

# set the prompt
set_prompt() {
    mypath="$C_OFF$C_L_GREEN%~"
    myjobs=()
    for a (${(k)jobstates}) {
        j=$jobstates[$a];i="${${(@s,:,)j}[2]}"
        myjobs+=($a${i//[^+-]/})
    }
    myjobs=${(j:,:)myjobs}
    ((MAXMID=$COLUMNS / 2)) # truncate to this value
    RPS1="$RPSL$C_L_GREEN%$MAXMID<...<$mypath$RPSR"
    rehash
}
RPSL=$'$C_OFF'
RPSR=$'$C_OFF$C_L_GREEN%(0?.$C_L_GREEN. (%?%))$C_OFF'
RPS2='%^'

precmd() {
    set_prompt
    print -Pn "\e]0;%n@$__IP:%l\a"
}
PS1=$'$C_GREEN%(1j.[$myjobs]% .)%m.%B%n%b$C_OFF$C_L_GREEN $(vcs_info_wrapper)%# $C_OFF'

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
