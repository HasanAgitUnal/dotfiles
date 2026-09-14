return {
        {
                "MeanderingProgrammer/render-markdown.nvim",
                dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
                ft = { "markdown" },
                opts = {
                        heading = { sign = true, icons = { " ", " ", " ", " ", " ", " " } },
                        code = { sign = false, width = "block", right_pad = 1 },
                        checkbox = {
                                enabled = true,
                                unchecked = { icon = "󰄱 " },
                                checked = { icon = "󰄲 " },
                                custom = {
                                        important = {
                                                raw = "[!]",
                                                rendered = " ",
                                                highlight = "RenderMarkdownChecked",
                                        },
                                        doing = { raw = "[/]", rendered = " ", highlight = "RenderMarkdownCurrent" },
                                        cancelled = {
                                                raw = "[~]",
                                                rendered = "󰜺 ",
                                                highlight = "RenderMarkdownUnchecked",
                                        },
                                        postponed = {
                                                raw = "[>]",
                                                rendered = "󱑂 ",
                                                highlight = "RenderMarkdownChecked",
                                        },
                                },
                        },
                },
        },
}
