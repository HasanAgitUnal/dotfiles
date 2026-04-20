# Exit if not running interactively
case $- in
    *i*) ;;
      *) return;;
esac

#####################################################################

#
# Settings
#

# Check window size after every command
shopt -s checkwinsize

# Changes behavior of "**" with this pattern you can search directory with subdirectories
shopt -s globstar

# Makes less can open non-text files with lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable vi mode
set -o vi

#####################################################################

#
# Imports
#

# Load aliases form ~/.bash_aliasses
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load variables from ~/.bash_env_vars
if [ -f ~/.bash_env_vars ]; then
    . ~/.bash_env_vars
fi

#####################################################################

#
# Bash History
#

# Dont add duplicate lines to history
HISTCONTROL=ignoredups

# History lenght
HISTSIZE=500
HISTFILESIZE=5000

# Append to the history file don't overwrite it
shopt -s histappend

#####################################################################

#
# Prompt && Colors
#

# Changes
git_dirty() {
        status=$(git status --porcelain 2>/dev/null)
        if [ -n "$status" ]; then

                if echo "$status" | grep -q "^??"; then
                        echo "*"
                        return
                fi

                if echo "$status" | grep -q "^.[MADRC]"; then
                        echo "*"
                        return
                fi

                if echo "$status" | grep -q "^[MADRC]"; then
                        echo "~"
                        return
                fi

        else
                echo
                return
        fi
}

# Git branch
git_branch() {
    local branch dirty=$(git_dirty)
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    echo -e " \033[32m>\033[1;33m ${dirty}${branch}\033[0m"
}

# Exit code
exit_code() {
        code=$?
        if [[ $code -eq 0 ]]; then
                echo -e "\033[0;32m>"
        else
                echo -e "\033[0;31m>$code"
        fi
}

# PS1
# Termux
#PROMPT_DIRTRIM=0
#PS1='$(exit_code) \[\033[1;3;36m\]\w\[\033[0m\]$(git_branch)\n\[\033[0;32m\]λ \[\033[0m\]'
# PC
PS1='$(exit_code) \[\033[1;3;36m\]\w\[\033[0m\]$(git_branch) \[\033[32m\]> \[\033[1;3;34m\]\h \[\033[0;32m\]> \[\033[1;3;31m\]\u
\[\033[0;32m\]λ \[\033[0m\]'

# Enable color support of ls and grep commands
if [ -x $PREFIX/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

        if [[ -f /usr/bin/eza ]];then
                alias eza='eza --icons'
                alias ls='eza --icons'
                alias ll='ls -algF -h --git'
        else
                alias ls='ls --color=auto'
                alias ll='ls -alF -h'
        fi

        alias la='ls -A'
        alias l='ls -F'

        alias dir='dir --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
        alias yay='yay --color=auto'

fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;33:note=01;36:caret=01;32:locus=01:quote=01'

#####################################################################

#
# Other
#


# Load NVM
[ -s "$NVM_DIR/nvm.sh" ] && \
        . "$NVM_DIR/nvm.sh"

# Start bash with $? = 0
true
