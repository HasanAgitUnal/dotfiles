--[[
        Hyprland
--]]

HOME = os.getenv("HOME")
configdir = HOME .. "/.config/hypr/config/"

function load(name)
        dofile(configdir .. name)
end

-- Variables
load("env.lua")
load("variables.lua")

-- General Settings
load("settings/monitors.lua")
load("settings/settings.lua")
load("settings/input.lua")

-- Autostart
load("autostart.lua")

-- Keybindings
load("keybinds.lua")

-- Visual Settings
load("visual/visual.lua")
load("visual/animations.lua")
load("visual/layouts.lua")

-- Rules
load("rules/windowrules.lua")
load("rules/layerrules.lua")
load("rules/workspacerules.lua")

