hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + Return", hl.dsp.exec_cmd("foot"))

local osd = "/home/melon/dotfiles/scripts/osd/osd.sh"
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(osd .. " brightness +5"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osd .. " brightness -5"), { locked = true, repeating = true })

hl.bind("SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd(osd .. " brightness +1"), { locked = true, repeating = true })

hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd(osd .. " brightness -1"), { locked = true, repeating = true })

hl.config({
	misc = {
		disable_hyprland_logo = true,
	},

	input = {
		kb_layout = "tr",
	},
	--        animations {
	--                enabled = false
	--        }
})

hl.on("hyprland.start", function()
	hl.exec_cmd('nwg-hello; hyprctl dispatch "hl.dsp.exit()"')
end)
