#/bin/sh

THEME_DIR="$HOME/.local/share/sounds/${CANBERRA_XDG_SOUND_THEME_NAME:-modern-minimal-ui-sounds}"

# Fallback to message-new-instant if message-new-email doesn't exist
if ls "$THEME_DIR/stereo/message-new-email".* >/dev/null 2>&1; then
    mpv "$THEME_DIR/stereo/message-new-email".* --no-terminal &
else
    mpv "$THEME_DIR/stereo/message-new-instant".* --no-terminal &
fi
