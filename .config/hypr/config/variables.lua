local terminal = "footclient"

APPS = {
        terminal      = terminal,

        -- File managers
        fileManagerTUI = terminal .. " yazi",
        fileManager   = "thunar",

        -- Scripts
        menu          = HOME .. "/dotfiles/.config/rofi/bin/rofi-menu",
        osd           = HOME .. "/dotfiles/scripts/osd/osd.sh",

        -- Browsers
        browser       = "flatpak run app.zen_browser.zen",      -- Firefox based
        browser_alt   = "/opt/helium-browser-bin/helium",       -- Chromium based

        -- TUI apps
        gemini = terminal .. " --title 'Gemini' --working-directory /tmp/gemini --app-id gemini gemini",
        notes  = terminal .. " --title 'Notes' --app-id notes --working-directory ~/documents/obsidian nvim TODOS.md",
        rogue  = terminal .. " --title 'Rogue' -o tweak.font-monospace-warn=no -o main.font='square:size=12.5' sh -c 'sleep 0.2; if [ -f ~/rogue.save ]; then rogue -r; else rogue; fi'"
}

SOUND_THEME = HOME .. "/.local/share/sounds/modern-minimal-ui-sounds"
