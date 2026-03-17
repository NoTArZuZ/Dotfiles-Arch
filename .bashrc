# Bash Init File

[[ $- != *i* ]] && return

# Prompt
PS1=" \[\e[1;37m\]\t\[\e[0m\] \[\e[1;34m\]\w \[\033[1;32m\]\[\e[0;37m\] "
PS0="\[\e[0m\]" # Reset colours after pressing enter

# Variables
PROMPT_COMMAND='history -a; echo -ne "\e[3 q"'
export PATH="$HOME/.local/bin:$PATH"
export INPUTRC="/home/$USER/.inputrc"
export EDITOR=nvim
export VISUAL=nvim
export PAGER=nvim
export QT_QPA_PLATFORMTHEME=gtk3
export QT_QPA_PLATFORMTHEME_QT6=gtk3
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T"
export HISTCONTROL=erasedups:ignoredups:ignorespace
export FZF_DEFAULT_OPTS='
  --color=dark
  --color=fg:-1,bg:-1,hl:4,fg+:15,bg+:0,hl+:6
  --color=info:5,prompt:2,pointer:2,marker:1,spinner:4,header:4
  --style minimal
'

# Aliases
alias "doas"="sudo"
alias "fucking"="sudo"
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
alias "pacQ"="pacman -Qq"
alias "pacQe"="pacman -Qqe"
alias "pacQm"="pacman -Qqm"
alias "paclog"="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort -n"
alias "pacelog"="expac --timefmt='%Y-%m-%d %T' '%l\t%n %w' | grep explicit | sort -n"
# Abbreviations
alias "pwmix"='wiremix'
alias "hx"='helix'
alias "nv"='nvim'
# One-liners
alias "ezfd"='find / -name $* 2>/dev/null'
alias "minifetch"='echo "" && fastfetch -c examples/8.jsonc --logo-padding-left 2'
alias "dict"='trans -v -d $*'
alias "clear"='clear && minifetch'
alias "config"='git -C ~/Dotfiles'
alias "getwinclass"='xdotool getwindowclassname "$(xdotool selectwindow)"'
alias "getwintitle"='xdotool getwindowname "$(xdotool selectwindow)"'
alias "procf"='ps aux | grep'
alias "mkxz"='tar cvJf'
alias "mkgz"='tar cvzf'
alias "llblk"='df -hT'
alias "qdiff"='diff -r -q'
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
alias "shx"='SUDO_EDITOR=helix sudoedit'
alias "rmpc-mini"="rmpc -c ~/.config/rmpc/config-mini.ron -t ~/.config/rmpc/themes/theme-mini.ron"
alias "rmpc-alt"="rmpc -c ~/.config/rmpc/config-alt.ron -t ~/.config/rmpc/themes/theme-alt.ron"

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
# Quickly z to folder, edit files with helix and then z to home
zhx() {
	z "${1}"
	hx .
	z
}
# Quickly z to folder and edit files with helix
zzhx() {
	z "${1}"
	hx .
}
# Edit a file in path with helix
bhx() {
	hx $(which "${1}")
}
bashmux() {
	tmux has-session -t main 2>/dev/null
	if [ $? != 0 ]; then
		tmux new-session -d -s main
	fi
	[ -z "$TMUX" ] && tmux attach -t main
}

# Startup Commands
shopt -s checkwinsize
shopt -s histappend
minifetch
# [ "$TERM" = "linux" ] || bashmux
[ -f /usr/bin/starship ] && eval "$(starship init bash)"
[ -f /usr/bin/fzf ] && FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
[ -f /usr/bin/zoxide ] && eval "$(zoxide init bash)"
