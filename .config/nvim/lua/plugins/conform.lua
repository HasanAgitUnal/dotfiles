return {
        {
                "stevearc/conform.nvim",
                opts = {
                        formatters_by_ft = {
                                c = { "clang-format" },
                                cpp = { "clang-format" },
                                lua = { "stylua" },
                                rust = { "rustfmt" },
                                typst = { "typstyle" },
                        },
                        format_on_save = {
                                timeout_ms = 500,
                                lsp_format = "never",
                        },
                        formatters = {
                                typstyle = {
                                        prepend_args = {
                                                "--indent-width",
                                                "4",

                                                "--line-width",
                                                "120",

                                                "--wrap-text",

                                                "--no-reorder-import-items",
                                        },
                                },
                        },
                },
        },
}
