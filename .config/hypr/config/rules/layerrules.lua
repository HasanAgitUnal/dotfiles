--[[
        Layer Rules
--]]

-- All of them below just applies blur & animation

hl.layer_rule({
         name           = "rofi",
         match          = { namespace = "rofi" },
         blur           = true,
         xray           = true,
         ignore_alpha   = 0.5,
         animation      = "slide left"
})

hl.layer_rule({
        name            = "dunst",
        match           = { namespace = "notifications" },
        blur            = true,
        ignore_alpha    = 0.5,
        animation       = "slide right"
})

hl.layer_rule({
        name            = "waybar",
        match           = { namespace = "waybar" },
        animation       = "slide top"
})

hl.layer_rule({
        name            = "wallpaper",
        match           = { namespace = "wallpaper" },
        animation       = "fade"
})
