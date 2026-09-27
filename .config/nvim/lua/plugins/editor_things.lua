return {
        "NMAC427/guess-indent.nvim",

        { "folke/which-key.nvim", event = "VimEnter", opts = { delay = 200 } },
        {
                "lewis6991/gitsigns.nvim",
                opts = { signs = { add = { text = "+" }, change = { text = "*" }, delete = { text = "-" } } },
        },
        {
                "folke/todo-comments.nvim",
                event = "VimEnter",
                dependencies = { "nvim-lua/plenary.nvim" },
                opts = { signs = false },
        },

        {
                "mfussenegger/nvim-lint",
                config = function()
                        require("lint").linters_by_ft = { c = { "clangtidy" } }
                        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                                callback = function()
                                        require("lint").try_lint()
                                end,
                        })
                end,
        },
}
