--[[
        Visual Settings
--]]

hl.config({
        general = {
                border_size = 2,

                gaps_in = 5,
                gaps_out = 10,

                resize_on_border = false,
                allow_tearing = false,
                layout = "dwindle",

                col = {
                        inactive_border = "#22222899",
                        active_border = { 
                                colors = { "#33335577", "#55559977" }, 
                                angle  = 315
                        }
                },
        },
 
        decoration = {
                rounding = 4,
                rounding_power = 2,

                active_opacity = 0.9,
                inactive_opacity = 0.6,
                dim_inactive = true,
                dim_strength = 0.06,

                blur = {
                        enabled = true,
                        size = 3,
                        passes = 2,
                        vibrancy = 0.1696,
                },

                shadow = {
                        enabled = true,
                        range = 6,
                        render_power = 5,
                        color = "#171720cc",
                }
        }
})
