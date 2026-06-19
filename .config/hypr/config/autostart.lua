--[[
        Autostart
--]]

hl.on("hyprland.start", function ()

        -- I dont remember why I added this
        hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && hyprshade auto")
        hl.exec_cmd("batsignal -w 15 -c 5 -d 2 -D \"shutdown now\" -b")

        -- Things
        hl.exec_cmd("swaybg -i ~/dotfiles/images/wallpaper.jpg -m fill")
        hl.exec_cmd("hyprctl setcursor LyraB-cursors 32")
        hl.exec_cmd("waybar")
        hl.exec_cmd("dunst")
        hl.exec_cmd("foot --server")

        -- AI Workspace
        hl.exec_cmd("mkdir -p /tmp/llxprt/sys")

        -- create symlink for systemprompts
        hl.exec_cmd("for prompt in " .. HOME .. "/.llxprt/sysprompts/*; do ln -sf $prompt /tmp/llxprt/sys/$(basename $prompt); done")

        -- Clipboard
        hl.exec_cmd("cliphist wipe")
        hl.exec_cmd("wl-paste --type text --watch cliphist -max-items 100 store")
        hl.exec_cmd("wl-paste --type image --watch cliphist -max-items 100 store")

        -- Startup Sound
        hl.exec_cmd("sh -c 'sleep 2 && mpv " .. SOUND_THEME .. "/stereo/desktop-login.*'")

end)

hl.on("hyprland.shutdown", function ()
        -- LLXPRT
        -- Clean symlink and directory
        hl.exec_cmd("for file in /tmp/llxprt/sys/*; do unlink $file; done && rm -rf /tmp/llxprt")
end)
