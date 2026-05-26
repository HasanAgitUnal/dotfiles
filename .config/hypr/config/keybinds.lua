--[[
        Keybindings
--]]

-- Mainmod
local mainMod = "SUPER"

-- Waybar
hl.bind(mainMod .. " + W",              hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mainMod .. " + SHIFT + W",      hl.dsp.exec_cmd("pkill -SIGUSR2 waybar"))

-- Basic things
hl.bind(mainMod .. " + BackSpace",      hl.dsp.window.close())
hl.bind(mainMod .. " + K",              hl.dsp.window.kill())
hl.bind(mainMod .. " + F",              hl.dsp.window.float())
hl.bind(mainMod .. " + S",              hl.dsp.layout("togglesplit"))

-- Apps

hl.bind(mainMod .. " + SPACE",          hl.dsp.exec_cmd(APPS.menu))
hl.bind(mainMod .. " + Return",         hl.dsp.exec_cmd(APPS.terminal))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(APPS.fileManager))
hl.bind(mainMod .. " + T",              hl.dsp.exec_cmd(APPS.fileManagerTUI))
hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd(APPS.browser))
hl.bind(mainMod .. " + C",              hl.dsp.exec_cmd(APPS.browser_alt))
hl.bind(mainMod .. " + G",              hl.dsp.exec_cmd(APPS.gemini))
hl.bind(mainMod .. " + N",              hl.dsp.exec_cmd(APPS.notes))
hl.bind(mainMod .. " + R",              hl.dsp.exec_cmd(APPS.rogue))

-- Screenshot
hl.bind("Print",                        hl.dsp.exec_cmd("sh -c 'mpv " .. SOUND_THEME .. [[/stereo/screen-capture.* & grim -g "$(slurp)" - | satty --filename - --output-filename ~/media/screenshots/$(date +%d-%m-%Y_%H-%M-%S).png']]))
hl.bind(mainMod .. " + Print",          hl.dsp.exec_cmd("sh -c 'mpv " .. SOUND_THEME .. [[/stereo/screen-capture.* & grim - | satty --filename - --output-filename ~/media/screenshots/$(date +%d-%m-%Y_%H-%M-%S).png']]))

-- Clipboard
hl.bind(mainMod .. " + V",              hl.dsp.exec_cmd([[cliphist list | rofi -dmenu -i -p "Clipboard" | cliphist decode | wl-copy]]))

-- Move focus
hl.bind(mainMod .. " + H",              hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J",              hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K",              hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L",              hl.dsp.focus({ direction = "right" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H",      hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J",      hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K",      hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L",      hl.dsp.window.move({ direction = "right" }))

-- Resize windows
hl.bind("SUPER + CTRL + H",             hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + L",             hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + K",             hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + J",             hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

-- Workspace Bindings
for i = 1, 10 do
        local key = i % 10 -- 0-9

        -- Switch Workspace 
        hl.bind(mainMod .. " + " .. key,                hl.dsp.focus({ workspace = i}))

        -- Move Window to Workspace
        hl.bind(mainMod .. " + SHIFT + " .. key,        hl.dsp.window.move({ workspace = i }))
end

-- Move / Resize Windows with mouse
hl.bind(mainMod .. " + mouse:272",                      hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273",                      hl.dsp.window.resize(), { mouse = true })

-- Mediakeys
hl.bind("XF86AudioMute",                                hl.dsp.exec_cmd(APPS.osd .. " mute-volume"),    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",                             hl.dsp.exec_cmd(APPS.osd .. " mute-mic"),       { locked = true, repeating = true })

hl.bind("XF86AudioRaiseVolume",                         hl.dsp.exec_cmd(APPS.osd .. " volume +5"),      { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",                         hl.dsp.exec_cmd(APPS.osd .. " volume -5"),      { locked = true, repeating = true })

hl.bind("SHIFT + XF86AudioRaiseVolume",                 hl.dsp.exec_cmd(APPS.osd .. " volume +1"),      { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioLowerVolume",                 hl.dsp.exec_cmd(APPS.osd .. " volume -1"),      { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp",                          hl.dsp.exec_cmd(APPS.osd .. " brightness +5"),  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",                        hl.dsp.exec_cmd(APPS.osd .. " brightness -5"),  { locked = true, repeating = true })

hl.bind("SHIFT + XF86MonBrightnessUp",                  hl.dsp.exec_cmd(APPS.osd .. " brightness +1"),  { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessDown",                hl.dsp.exec_cmd(APPS.osd .. " brightness -1"),  { locked = true, repeating = true })

-- Playerctl
hl.bind("XF86AudioNext",                                hl.dsp.exec_cmd(" playerctl next"),             { locked = true })
hl.bind("XF86AudioPause",                               hl.dsp.exec_cmd(" playerctl play-pause"),       { locked = true })
hl.bind("XF86AudioPlay",                                hl.dsp.exec_cmd(" playerctl play-pause"),       { locked = true })
hl.bind("XF86AudioPrev",                                hl.dsp.exec_cmd(" playerctl previous"),         { locked = true })
