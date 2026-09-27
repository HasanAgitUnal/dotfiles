return {
        {
                "echasnovski/mini.nvim",
                config = function()
                        require("mini.ai").setup({ n_lines = 500 })
                        require("mini.surround").setup({
                                mappings = {
                                        add = "sa",
                                        delete = "sd",
                                        replace = "sr",
                                        find = "sf",
                                        find_left = "sF",
                                        highlight = "sh",
                                },
                        })

                        require("mini.align").setup()

                        local statusline = require("mini.statusline")
                        statusline.setup({
                                use_icons = vim.g.have_nerd_font,
                                content = {
                                        active = function()
                                                local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
                                                local filename = statusline.section_filename({ trunc_width = 140 })
                                                local location = statusline.section_location({ trunc_width = 75 })
                                                local ft = vim.bo.filetype
                                                local icon = ""
                                                if vim.g.have_nerd_font then
                                                        local ok, devicons = pcall(require, "nvim-web-devicons")
                                                        if ok then
                                                                icon = devicons.get_icon_by_filetype(
                                                                        ft,
                                                                        { default = true }
                                                                ) .. " "
                                                        end
                                                end
                                                local filetype_str = icon .. ft
                                                return statusline.combine_groups({
                                                        { hl = mode_hl, strings = { mode } },
                                                        { hl = "MiniStatuslineFilename", strings = { filename } },
                                                        "%#MiniStatuslineInactive#%=",
                                                        { hl = mode_hl, strings = { location } },
                                                        { hl = "MiniStatuslineFilename", strings = { filetype_str } },
                                                })
                                        end,
                                },
                        })
                        statusline.section_location = function()
                                return "%2l:%-2v"
                        end
                        require("mini.base16").setup({
                                palette = {
                                        base00 = "#111117",
                                        base01 = "#171720",
                                        base02 = "#272740",
                                        base03 = "#424242",
                                        base04 = "#a0a0a0",
                                        base05 = "#e0e0e0",
                                        base06 = "#f0f0f0",
                                        base07 = "#ffffff",
                                        base08 = "#6bc7dd",
                                        base09 = "#207d8a",
                                        base0A = "#e1ea8c",
                                        base0B = "#50ea7b",
                                        base0C = "#6bc7dd",
                                        base0D = "#207d8a",
                                        base0E = "#ee79c6",
                                        base0F = "#cfcfcf",
                                },
                        })
                end,
        },
}
