#
# ALIASES
#

if [[ -f ~/.zoxide_aliases ]]; then
        . ~/.zoxide_aliases
        alias cd='z'
fi

alias open='xdg-open'
alias up="pkg update && pkg upgrade"
alias update="up && apt autoremove && pkg clean"
alias ub='source $HOME/.bashrc'
alias spp='while true; do clear; sensors; sleep 1; done;'
alias pyenv="source ~/env/bin/activate"
alias rick="curl ascii.live/rick &
mpv ~/rick.mp3 >/dev/null 2>/dev/null
pkill -f 'curl ascii' >/dev/null 2>/dev/null
clear"
alias gs="git status -s"
alias as="apt search"
alias lam="am start"
alias e="exit 0"
alias p='for i in {0..255}; do printf "\x1b[38;5;${i}m%3d " $i; if (( $i % 16 == 15 )); then echo; fi; done'
alias srogue="rogue ~/rogue.save"
alias c="clear"
alias fastusage="fastfetch -c examples/9"
alias fastlong="fastfetch -c long"
alias kde-clean="find ~/.config ~/.cache ~/.local/share -maxdepth 1 \( -name 'k*' -o -name 'plasma*' -o -name 'baloo*' \) -not -name 'keepassxc*' -exec rm -rf {} + && echo 'KDE shits are destroyed'"
alias termres='echo $(tput cols)x$(tput lines)'
alias notes='nvim ~/documents/obsidian'
alias todo='nvim ~/documents/obsidian/TODOS.md'
alias cmatrix='cmatrix -C cyan -b'
alias sync='apikey=$(syncthing cli config gui apikey get); gui="127.0.0.1:8384"; folders=$(syncthing cli config folders list); devices=$(syncthing cli config devices list); printf "%-15s | %-15s | %s\n" "KLASOR" "CIHAZ" "GUNCEL %"; for f in $folders; do for d in $devices; do name=$(syncthing cli config devices $d name get); completion=$(curl -s -H "X-API-Key: $apikey" "http://$gui/rest/db/completion?folder=$f&device=$d" | grep -oP '\''"completion":\s*\K[0-9.]+'\''); [ ! -z "$completion" ] && printf "%-15s | %-15s | %s%%\n" "$f" "$name" "$completion"; done; done'
alias onefetch='onefetch --include-hidden'
alias rr='rm -r'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias lsblks='lsblk -o NAME,SIZE,FSAVAIL,FSUSE%'
alias lsblkid='lsblk -o NAME,UUID'
alias lsblkd='lsblk -o NAME,FSTYPE,MOUNTPOINTS'
alias n='nvim'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

alert() {
    eject
#    for i in {1..5}; do
#        brightnessctl --device='input3::capslock' set 1 >/dev/null
#        sleep 0.5
#        brightnessctl --device='input3::capslock' set 0 >/dev/null
#        sleep 0.5
#    done
}

