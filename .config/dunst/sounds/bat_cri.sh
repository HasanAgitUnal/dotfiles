#/bin/sh

THEME_DIR="$HOME/.local/share/sounds/${CANBERRA_XDG_SOUND_THEME_NAME:-modern-minimal-ui-sounds}"
mpv "$THEME_DIR/stereo/battery-caution".* --no-terminal &
