return {
        {
                "nvim-telescope/telescope.nvim",
                event = "VimEnter",
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
                        { "nvim-telescope/telescope-ui-select.nvim" },
                        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
                },
                config = function()
                        require("telescope").setup {
                                extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown() } }
                        }
                        pcall(require("telescope").load_extension, "fzf")
                        pcall(require("telescope").load_extension, "ui-select")
                        local builtin = require "telescope.builtin"
                        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
                        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
                        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
                        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
                        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
                        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
                        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
                        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
                        vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files " })
                        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

                        vim.keymap.set("n", "<leader>/", function()
                                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown { winblend = 10 })
                        end, { desc = "[/] Fuzzily search in current buffer" })

                        vim.keymap.set("n", "<leader>s/", function()
                                builtin.live_grep { grep_open_files = true, prompt_title = "Live Grep in Open Files" }
                        end, { desc = "[S]earch [/] in Open Files" })

                        vim.keymap.set("n", "<leader>sn", function()
                                builtin.find_files { cwd = vim.fn.stdpath "config" }
                        end, { desc = "[S]earch [N]eovim files" })
                end,
        },

        "NMAC427/guess-indent.nvim",

        { "folke/which-key.nvim", event = "VimEnter", opts = { delay = 200 } },
        { "lewis6991/gitsigns.nvim", opts = { signs = { add = { text = "+" }, change = { text = "*" }, delete = { text = "-" } } } },
        { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },

        {
                "echasnovski/mini.nvim",
                config = function()
                        require("mini.ai").setup { n_lines = 500 }
                        require("mini.surround").setup()

                        local statusline = require "mini.statusline"
                        statusline.setup {
                                use_icons = vim.g.have_nerd_font,
                                content = {
                                        active = function()
                                                local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
                                                local filename      = statusline.section_filename({ trunc_width = 140 })
                                                local location      = statusline.section_location({ trunc_width = 75 })
                                                local ft            = vim.bo.filetype
                                                local icon = ""
                                                if vim.g.have_nerd_font then
                                                        local ok, devicons = pcall(require, "nvim-web-devicons")
                                                        if ok then icon = devicons.get_icon_by_filetype(ft, { default = true }) .. " " end
                                                end
                                                local filetype_str = icon .. ft
                                                return statusline.combine_groups({
                                                        { hl = mode_hl,                  strings = { mode } },    
                                                        { hl = "MiniStatuslineFilename",  strings = { filename } },
                                                        "%#MiniStatuslineInactive#%=",
                                                        { hl = mode_hl,                  strings = { location } }, 
                                                        { hl = "MiniStatuslineFilename",  strings = { filetype_str } },
                                                })
                                        end,
                                },
                        }
                        statusline.section_location = function() return "%2l:%-2v" end

                        require("mini.base16").setup({
                                palette = {
                                        base00 = "#111117", base01 = "#171720", base02 = "#272740", base03 = "#424242",
                                        base04 = "#a0a0a0", base05 = "#e0e0e0", base06 = "#f0f0f0", base07 = "#ffffff",
                                        base08 = "#6bc7dd", base09 = "#207d8a", base0A = "#e1ea8c", base0B = "#50ea7b",
                                        base0C = "#6bc7dd", base0D = "#207d8a", base0E = "#ee79c6", base0F = "#cfcfcf",
                                }
                        })
                end,
        },

        {
                "stevearc/conform.nvim",
                opts = {
                        formatters_by_ft = { c = { "clang-format" }, cpp = { "clang-format" } },
                        format_on_save = true,
                },
        },
        {
                "mfussenegger/nvim-lint",
                config = function()
                        require("lint").linters_by_ft = { c = {"clangtidy"} }
                        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                                callback = function() require("lint").try_lint() end,
                        })
                end
        },
}
