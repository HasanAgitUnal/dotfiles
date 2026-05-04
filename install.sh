#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"

linkm() {
    echo -e "[ \033[3;35mlinking\033[0m ] $1"
}

safelink() {
        local src="$1"
        local dest="$2"
        local name=$(basename "$dest")

        if [ -e "$dest" ] || [ -L "$dest" ]; then
                echo -e "\n[ \033[1;33mWarning\033[0m ] $name already exists"
                read -p "Delete and relink it? [y/N]: " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                        rm -rf "$dest"
                        ln -sf "$src" "$dest"
                        echo -e "\033[36m$name (replaced)\033[0m"
                else
                        echo -e "\033[36m$name (skipped)\033[0m"
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
                echo -e "[ \033[33mWarning\033[0m ] /etc configs are not copied to copy them run:\n\tsudo $0 etc"
        fi
}

cat <<EOF

\033[1;36m * CybrCyanDots * \033[0m

\033[3;32mIMPORTANT NOTE: NEVER delete ~/dotfiles directory.
                Everything is symlink for it\033[0m

EOF

# Copying only /etc folders
if [[ $1 == "etc" ]]; then
        linkm "Linking /etc folders"
        root
        exit 0
fi

if [[ $(pwd) != "$DOTFILES_DIR" ]]; then
        echo -e "[ \033[31mERROR\033[0m ] Please run inside $DOTFILES_DIR directory"
        exit 1
fi

# ~/.config
for file in .bashrc .bash_aliases .bash_env_vars .clang-format .inputrc; do
        linkm "$file"
        safelink "$DOTFILES_DIR/$file" "$HOME/$file"
done

# ~/.config
mkdir -p "$HOME/.config"
for dir in "$DOTFILES_DIR/.config/"*/; do
        name=$(basename "$dir")
        linkm "$name"
        safelink "$dir" "$HOME/.config/$name"
done

# /etc
root

echo "[ \033[1;32mCompleted\033[0m ] Files are linked to $DOTFILES_DIR. DONT DELETE IT!!"
