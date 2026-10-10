--[[
        Monitors
--]]

-- Let Hyprland pick itself on single monitor
--hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- Laptop
MONITOR_DOWN = "eDP-1"
hl.monitor({ output = MONITOR_DOWN, mode = "1366x768@60", position = "0x0", scale = 1 })

-- TV
MONITOR_UP = "HDMI-A-2"
hl.monitor({
        output = MONITOR_UP,
        mode = "1920x1080@60",
        position = "0x-720",
        scale = 1.5,
})
