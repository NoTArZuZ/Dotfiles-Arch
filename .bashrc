# Bash Init File

[[ $- != *i* ]] && return

# Prompt
PS1=" \[\e[4;37m\]\t\[\e[0m\] \[\e[1;34m\]\w \[\033[1;32m\]󰅂\[\e[0;37m\] "
PS0="\[\e[0m\]" # Reset colours after pressing enter

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

# Aliases
# Pacman
alias "pacS"='yay -S'
alias "pacSs"='yay -Ss'
alias "pacScc"='yay -Scc'
alias "pacSyu"='sudo pacman -Syu'
alias "pacSq"="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
alias "pacR"='yay -R'
alias "pacRd"='yay -Rdd'
alias "pacRc"='yay -Rcuns'
alias "pacRq"="yay -Qq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -Rcuns"
# Abbreviations
alias "yazi"='TERM=foot yazi'
alias "pwmix"='pulsemixer'
alias "hx"='helix'
# One-liners
alias "ezfd"='find / -name $* 2>/dev/null'
alias "ufetch"='/home/$USER/ufetch-arch'
alias "clear"='clear && ufetch'
alias "config"='git -C ~/Dotfiles'
alias "diffconfig"='~/diffdotfiles'
alias "getwinclass"='xdotool getwindowclassname "$(xdotool selectwindow)"'
alias "getwintitle"='xdotool getwindowname "$(xdotool selectwindow)"'
alias "procf"='ps aux | grep'
alias "mkxz"='tar cvJf'
alias "mkgz"='tar cvzf'
alias "llblk"='df -hT'
# Argument config
alias "mv"='mv -i'
alias "cp"='cp -i'
alias "ln"='ln -i'
alias "rm"='rm -I'
alias "ls"='eza --icons -a1'
alias "ll"='eza --icons --git -al'
alias "tree"='eza --icons -aT'
alias "grep"='grep --color=auto'
alias "diff"='diff --color'

# Functions
# Extract various archives
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
# Find file by content in pwd
ftext() {
	grep -iIHrn --color=always "$1" . | less -r
}
# Find file by content in specified dir
fetext() {
	grep -iIHrn --color=always $1 $2 | less -r
}
# Copy a FILE with progress bar
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
if [ -f /usr/bin/starship ]; then
	eval "$(starship init bash)"
fi
FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
eval "$(zoxide init bash)"
