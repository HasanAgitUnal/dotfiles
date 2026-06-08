--[[
        Autostart
--]]

hl.on("hyprland.start", function ()

        -- I dont remember why I added this
        hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && hyprshade auto")

        -- Things
        hl.exec_cmd("swaybg -i ~/dotfiles/images/wallpaper.jpg -m fill")
        hl.exec_cmd("hyprctl setcursor LyraB-cursors 32")
        hl.exec_cmd("waybar")
        hl.exec_cmd("dunst")
        hl.exec_cmd("foot --server")

        -- AI Workspace
        hl.exec_cmd("mkdir -p /tmp/llxprt")
        hl.exec_cmd("ln -sf " .. HOME .. "/dotfiles/.llxprt/sysprompts /tmp/llxprt/sys")

        -- Clipboard
        hl.exec_cmd("cliphist wipe")
        hl.exec_cmd("wl-paste --type text --watch cliphist -max-items 100 store")
        hl.exec_cmd("wl-paste --type image --watch cliphist -max-items 100 store")

        -- Startup Sound
        hl.exec_cmd("sh -c 'sleep 2 && mpv " .. SOUND_THEME .. "/stereo/desktop-login.*'")

end)
