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

# Prompt
PS1="\[\e[1;34m\] 󰣇 \[\e[1;32m\] \w \[\033[1;35m\]󰅂\[\e[0;37m\] "

# Variables
PROMPT_COMMAND='history -a'
export INPUTRC="/home/$USER/.inputrc"
export QT_QPA_PLATFORMTHEME=gtk2
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T"
export HISTCONTROL=erasedups:ignoredups:ignorespace
export EDITOR=helix
export visual=helix
export FZF_DEFAULT_OPTS='
  --color=dark
  --color=fg:-1,bg:-1,hl:4,fg+:15,bg+:0,hl+:6
  --color=info:5,prompt:2,pointer:2,marker:1,spinner:4,header:4
  --style minimal
'

# Pacman Aliases
alias "pacS"="yay -S"
alias "pacSs"="yay -Ss"
alias "pacScc"="yay -Scc"
alias "pacSyu"="sudo pacman -Syu"
alias "pacSq"="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
alias "pacRc"="sudo pacman -Rcuns"
alias "pacRd"="sudo pacman -Rdd"
alias "pacR"="sudo pacman -R"
# Abbreviations
alias "yazi"="TERM=foot yazi"
alias "pwmix"="pulsemixer"
alias "hx"="helix"
# One-liners
alias "ezfd"="find / -name "$*" 2>/dev/null"
alias "ufetch"="/home/$USER/ufetch-arch"
alias "clear"="clear && ufetch"
alias "config"="git -C ~/Dotfiles"
alias "diffconfig"="~/diffdotfiles"
# Argument config
alias "ls"="eza --icons -a1"
alias "ll"="eza --icons --git -al"
alias "tree"="eza --icons -aT"
alias "grep"="grep --color=auto"
alias "diff"="diff --color"

# Functions
extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.tar.xz) tar xvJf $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.zip) unzip $archive ;;
			*.7z) 7z x $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}
ftext() {
	grep -iIHrn --color=always "$1" . | less -r
}
fetext() {
	grep -iIHrn --color=always $1 $2 | less -r
}
cpb() {
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Startup Commands
shopt -s checkwinsize
shopt -s histappend
ufetch
FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
eval "$(zoxide init bash)"
