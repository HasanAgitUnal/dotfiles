--[[
        Window Rules
--]]

-- Satty window large & floating
hl.window_rule({
        name            = "satty",
        match           = { class = "com.gabm.satty" },
        float           = true,
        size            = {1320, 700},
        center          = true
})

-- Fuckup maximizing
hl.window_rule({
        name            = "maximize-fucker",
        match           = { class = ".*" },
        suppress_event  = "maximize"
})

-- Fix some dragging issues with XWayland
-- Comes from default hyprland config
hl.window_rule({
        name            = "fix-xwayland-drags",
 
        match = {
                class = "^$",
                title = "^$",
                xwayland = true,
                float = true,
                fullscreen = false,
                pin = false
        },

        no_focus = true
})

-- File pickers & Confirmation Popups
hl.window_rule({
        name            = "file-pickers",
        match           = { title = ".*(Choose|Open|Select|Save|Dosya|Seç|Kaydet|Yükle|Aç).*" },
        float           = true,
        size            = {1000, 600},
        center          = true
})

hl.window_rule({
        name            = "confirmation-popups",
        match           = { title = ".*(Confirm|Warn|Error|ERROR|Onayla|Uyarı|Hata|HATA).*" },
        float           = true,
        center          = true
})


--
-- Special Workspaces
--

-- Web
hl.window_rule({
        name            = "web-workspace",
        match           = { class = "app.zen_browser.zen|heluim-workspace" },
        workspace       = 3
})

-- AI
hl.window_rule({
        name            = "ai-workspace",
        match           = { class = "gemini" },
        workspace       = 4
})

-- Notes
hl.window_rule({
        name            = "notes-workspace",
        match           = { class = "notes" },
        workspace       = 5
})
