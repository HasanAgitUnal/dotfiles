hl.on("hyprland.start", function ()
        hl.exec_cmd("hyprctl setcursor LyraB-cursors 32")
        hl.exec_cmd("GTK_THEME=CybrCyanMateria ADW_DEBUG_COLOR_SCHEME=prefer-dark regreet")
end)

hl.window_rule({
        name = "regreet-fs",

        match = {
                class = ".*regreet.*"
        },

        fullscreen = true
})

hl.config({
        misc = {
                disable_hyprland_logo = true,
                disable_splash_rendering = true
        },

        ecosystem = {
                no_donation_nag = true
        },

        input = {
                kb_layout = "tr"
        }
})
