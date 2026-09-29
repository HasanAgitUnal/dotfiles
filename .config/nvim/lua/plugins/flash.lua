return {
        {
                "folke/flash.nvim",
                event = "VeryLazy",
                opts = {
                        labels = "asdfjklşghqwertyuıop",
                        modes = {
                                search = {
                                        enabled = true,
                                },
                                char = {
                                        keys = { "f", "F" }, -- do not override t and T
                                        jump_labels = true,
                                },
                        },
                },
                keys = {
                        -- gw from helix
                        {
                                "gw",
                                mode = { "n", "x", "o" },
                                function()
                                        require("flash").jump()
                                end,
                                desc = "Flash jump",
                        },
                        -- select mode gw
                        {
                                "<c-s>",
                                mode = { "c" },
                                function()
                                        require("flash").toggle()
                                end,
                                desc = "Flash Search Toggle",
                        },
                        -- remote actions power
                        {
                                "gr",
                                mode = { "o" },
                                function()
                                        require("flash").remote()
                                end,
                                desc = "Flash Remote Action",
                        },
                },
        },
}
