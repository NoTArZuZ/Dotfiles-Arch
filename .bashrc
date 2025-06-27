# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
[[ $- != *i* ]] && return

# Put your fun stuff here.
export INPUTRC="/home/$USER/.inputrc"
export QT_QPA_PLATFORMTHEME=gtk2
PS1="\[\e[1;34m\] 󰣇 \[\e[1;32m\] \w \[\033[1;35m\]󰅂\[\e[0;37m\] "
alias "pacS"="yay -S"
alias "pacSs"="yay -Ss"
alias "pacScc"="yay -Scc"
alias "pacSyu"="sudo pacman -Syu"
alias "pacRc"="sudo pacman -Rcuns"
alias "pacRd"="sudo pacman -Rdd"
alias "pacR"="sudo pacman -R"
alias "yazi"="TERM=foot yazi"
alias "pwmix"="pulsemixer"
alias "ezfd"="find / -name "$*" 2>/dev/null"
alias "ls"="eza --icons -a1"
alias "ll"="eza --icons --git -al"
alias "tree"="eza --icons -aT"
alias "grep"="grep --color=auto"
alias "hx"="helix"
alias "ufetch"="/home/$USER/ufetch-arch"

export FZF_DEFAULT_OPTS='
  --color=dark
  --color=fg:-1,bg:-1,hl:4,fg+:15,bg+:0,hl+:6
  --color=info:5,prompt:2,pointer:2,marker:1,spinner:4,header:4
  --style minimal
'

ufetch
FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
eval "$(zoxide init bash)"
