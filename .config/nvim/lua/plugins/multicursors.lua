return {
        {
                "jake-stewart/multicursor.nvim",
                branch = "1.0",
                config = function()
                        local mc = require("multicursor-nvim")
                        mc.setup()

                        local map = function(keys, func, desc, mode)
                                mode = mode or { "n", "x" }
                                vim.keymap.set(mode, keys, func, { desc = "MC: " .. desc })
                        end

                        map("<up>", function()
                                mc.lineAddCursor(-1)
                        end, "Add cursor up")

                        map("<down>", function()
                                mc.lineAddCursor(1)
                        end, "Add cursor down")

                        map("<M-up>", function()
                                mc.lineSkipCursor(-1)
                        end, "Move main cursor up")

                        map("<M-down>", function()
                                mc.lineSkipCursor(1)
                        end, "Move main cursor down")

                        map("<M-n>", function()
                                mc.matchAddCursor(1)
                        end, "Add cursor with search")

                        map("<M-N>", function()
                                mc.matchAddCursor(-1)
                        end, "Add cursor with backwards search")

                        map("<M-s>", function()
                                mc.matchSkipCursor(1)
                        end, "Move main cursor with search")

                        map("<M-S>", function()
                                mc.matchSkipCursor(-1)
                        end, "Move main cursor with backwards search")

                        map("<M-q>", mc.toggleCursor, "Enable/Disable cursors")

                        -- s and S features from helix
                        map("<S-S>", mc.splitCursors, "Split by pattern")
                        map("S", mc.matchCursors, "Select by pattern")

                        -- rotating text
                        -- FIX: flash.nvim is overriding them
                        map("t", function()
                                mc.transposeCursors(1)
                        end, "Rotate selections forward", { "x" })

                        map("T", function()
                                mc.transposeCursors(-1)
                        end, "Rotate selections backward", { "x" })

                        mc.addKeymapLayer(function(layerSet)
                                -- switch to prev cursor
                                layerSet({ "n", "x" }, "<M-left>", mc.prevCursor)
                                -- switch to next cursor
                                layerSet({ "n", "x" }, "<M-right>", mc.nextCursor)
                                -- delete the cursor
                                layerSet({ "n", "x" }, "<M-x>", mc.deleteCursor)
                                -- align cursors
                                layerSet({ "n", "x" }, "<M-a>", mc.alignCursors)

                                layerSet("n", "<esc>", function()
                                        if not mc.cursorsEnabled() then
                                                -- enable disabled cursors if disabled cursors exists
                                                mc.enableCursors()
                                        else
                                                -- remove all active cursors
                                                mc.clearCursors()
                                        end
                                end)
                        end)

                        local hl = vim.api.nvim_set_hl
                        hl(0, "MultiCursorCursor", { reverse = true, fg = "#888888" })
                        hl(0, "MultiCursorVisual", { link = "Visual" })
                        hl(0, "MultiCursorSign", { link = "SignColumn" })
                        hl(0, "MultiCursorMatchPreview", { link = "Search" })
                        hl(0, "MultiCursorDisabledCursor", { reverse = true })
                        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
                        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
                end,
        },
}
