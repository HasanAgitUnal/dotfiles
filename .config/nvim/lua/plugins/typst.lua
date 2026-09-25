return {
        {
                "kaarmu/typst.vim",
                ft = "typst",
                init = function()
                        -- Plugin yüklenmeden ÖNCE ayarlanmalı
                        vim.g.typst_pdf_viewer = "zathura"
                        vim.g.typst_conceal = 0
                end,
                config = function()
                        vim.api.nvim_create_autocmd("FileType", {
                                pattern = "typst",
                                callback = function(args)
                                        local opts = { buffer = args.buf, silent = true }

                                        vim.keymap.set(
                                                "n",
                                                "<leader>gtc",
                                                ":make<CR>",
                                                vim.tbl_extend("force", opts, { desc = "Typst [C]ompile" })
                                        )

                                        vim.keymap.set(
                                                "n",
                                                "<leader>gtw",
                                                ":TypstWatch<CR>",
                                                vim.tbl_extend("force", opts, { desc = "Typst [W]atch" })
                                        )

                                        vim.keymap.set(
                                                "n",
                                                "<leader>gts",
                                                ":silent! !pkill -f 'typst watch'<CR>",
                                                vim.tbl_extend("force", opts, { desc = "Typst [S]top Watch" })
                                        )

                                        vim.keymap.set("n", "<leader>gtC", function()
                                                local pdf = vim.fn.expand("%:p:r") .. ".pdf"
                                                if vim.fn.filereadable(pdf) == 1 then
                                                        vim.fn.delete(pdf)
                                                        print("Removed: " .. pdf)
                                                else
                                                        print("Not found: " .. pdf)
                                                end
                                        end, vim.tbl_extend(
                                                "force",
                                                opts,
                                                { desc = "Typst [C]lean" }
                                        ))
                                end,
                        })
                end,
        },
}
