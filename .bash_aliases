#
# ALIASES
#

if [[ -f ~/.zoxide_aliases ]]; then
        . ~/.zoxide_aliases
        alias cd='z'
fi

if [[ -e /storage/emulated/0 ]]; then
        GEMINI_TMP="$PREFIX/tmp/gemini"
else
        GEMINI_TMP="/tmp/gemini"
fi

mkdir -p "$GEMINI_TMP"
alias gt="cd $GEMINI_TMP && gemini"
alias pod-latexmk='podman run --rm -v "$PWD":/data:Z -w /data kjarosh/latex:full latexmk'
alias ub='source $HOME/.bashrc'
alias open='xdg-open'
alias spp='while true; do clear; sensors; sleep 1; done;'
alias pyenv="source ~/env/bin/activate"
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
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias lsblks='lsblk -o NAME,SIZE,FSAVAIL,FSUSE%'
alias lsblkid='lsblk -o NAME,UUID'
alias lsblkd='lsblk -o NAME,FSTYPE,MOUNTPOINTS'
alias n='nvim'
alias ws="$HOME/.llxprt/bin/search.sh"
alias makej='make -j$(nproc)'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# history search with ctrl+r
eval "$(fzf --bash)"

fdf() {
        local file
        file=$(fd --type f --hidden --exclude .git | fzf --height 50% --preview "bat --style=numbers --color=always {} 2>/dev/null || cat {}")
        if [[ -n "$file" ]]; then
                $EDITOR "$file"
        fi
}

alert() {
        "$@"
        eject
        echo -e "\a"
        notify-send "Alert" "Finished: $*" -u critical
}

tuxrick () {
        for l in "Never gonna give you up" "Never gona let you down" "Never gonna run around and dessert you" \
                 "Never gonna make you cry" "Never gonna say goodbye" "Never gonna hurt you"; do
 
                clear
                echo "$l" | cowsay -f tux | lolcat
                sleep "$1"
        done
}

rick () {
        echo -e "\e[33m"; curl ascii.live/rick &
        footclient -o font="CaskaydiaCove Nerd Font:size=18.5" bash -i -c "tuxrick 2.5"
        pkill -f "curl ascii.live/rick"
        clear
}
