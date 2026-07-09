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
        ai = terminal .. " --title 'AIChat' --app-id ai --working-directory /tmp/ai bash -c 'source ~/.env && aichat -s -f ~/dotfiles/ai/AGENT.md; if (( $? != 0 )); then read -p \"\n\x1b[31m> $?\x1b[0m > Press Enter to exit.\"; fi'",
        notes  = terminal .. " --title 'Notes' --app-id notes --working-directory ~/documents/obsidian nvim TODOS.md",
        rogue  = terminal .. " --title 'Rogue' -o tweak.font-monospace-warn=no -o main.font='square:size=12.5' sh -c 'sleep 1; if [ -f ~/rogue.save ]; then rogue -r; else rogue; fi'"
}

SOUND_THEME = HOME .. "/.local/share/sounds/modern-minimal-ui-sounds"
