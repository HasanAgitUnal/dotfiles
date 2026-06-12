#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"
NO_ASK=false

# Check for --no-ask parameter
for arg in "$@"; do
    if [[ $arg == "--no-ask" ]]; then
        NO_ASK=true
    fi
done

linkm() {
    echo -e "[ \033[35mLinking\033[0m  ] $1"
}

safelink() {
        local src="$1"
        local dest="$2"
        local name=$(basename "$dest")

        if [ -e "$dest" ] || [ -L "$dest" ]; then
                if [ "$NO_ASK" = true ]; then
                        rm -rf "$dest"
                        ln -sf "$src" "$dest"
                        return
                fi
                echo -e "[ \033[33mWarning\033[0m  ] $name already exists"
                read -p "$(echo -e "[ \033[34mAsk\033[0m      ] Delete and relink it? [y/N]: ")" -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                        rm -rf "$dest"
                        ln -sf "$src" "$dest"
                        echo -e "[ \033[36mReplaced\033[0m ] $name"
                else
                        echo -e "[ \033[36mSkipped\033[0m  ] $name"
                fi
        else
                ln -sf "$src" "$dest"
        fi
}

root () {
        if [ "$EUID" -eq 0 ]; then
                for file in "$DOTFILES_DIR/system/etc/"*; do
                        name=$(basename "$file")
                        linkm "$name"
                        safelink "$file" "/etc/$name"
                done
        else
                echo -e "[ \033[33mWarning\033[0m  ] /etc configs are not copied to copy them run:\n            sudo $0 etc"
        fi
}

user () {
        # ~/.*
        for file in .bashrc .bash_aliases .zoxide_aliases .bash_env_vars .clang-format .inputrc .llxprt .termux; do
                linkm "$file"
                safelink "$DOTFILES_DIR/$file" "$HOME/$file"
        done

        # ~/.config
        mkdir -p "$HOME/.config"
        for dir in "$DOTFILES_DIR/.config/"*; do
                name=$(basename "$dir")
                linkm "$name"
                safelink "$dir" "$HOME/.config/$name"
        done
}

echo
echo -e "\033[1;36m * CybrCyanDots * \033[0m"
echo
echo -e "\033[3;33mIMPORTANT NOTE:\033[0m" 
echo "NEVER delete ~/dotfiles directory."
echo "Everything is symlink for it"
echo

if [[ $(pwd) != "$DOTFILES_DIR" ]]; then
        echo -e "[ \033[31mERROR\033[0m ] Please run inside $DOTFILES_DIR directory"
        exit 1
fi

# Copying only /etc folders
if [[ $1 == "root" ]]; then
        linkm "Linking /etc folders"
        root
        echo -e "[ \033[1;32mFinished\033[0m ] Files are linked to $DOTFILES_DIR. DONT DELETE IT!!"
        exit 0
fi

if [[ $1 == "user" ]]; then
        linkm "Linking ~ folders"
        user
        echo -e "[ \033[1;32mFinished\033[0m ] Files are linked to $DOTFILES_DIR. DONT DELETE IT!!"
        exit 0
fi

if [[ $1 == "all" ]]; then
        root
        user
fi

# Run all if not $1 specified
all=false
echo -e "[ \033[33mWarning\033[0m  ] No mode specified use \"$0 user\" to install user configs or \"sudo $0 root\" to install system-wide configs or \"sudo $0 all\" to install both"
if [[ $NO_ASK == "false" ]]; then
        read -p "$(echo -e "[ \033[34mAsk\033[0m      ] Install all? [Y/n]: ")" confirmall 
        if [[ $confirmall =~ ^[Yy]$ ]]; then
                all=true
        fi

else
        all=true
fi

if [[ $all == true ]]; then
        root
        user
fi

echo -e "[ \033[1;32mFinished\033[0m ] Files are linked to $DOTFILES_DIR. DONT DELETE IT!!"
