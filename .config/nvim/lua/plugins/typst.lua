vim.g.typst_pdf_viewer = "zathura"
vim.g.typst_conceal = 0

vim.keymap.set("n", "<leader>gtc", ":make<CR>", { desc = "Typst [C]ompile" })
vim.keymap.set("n", "<leader>gtw", ":TypstWatch<CR>", { desc = "Typst [W]atch" })
vim.keymap.set("n", "<leader>gts", ":!pkill -f 'typst watch'", { desc = "Typst [S]top Watch" })

return {
        {
                "kaarmu/typst.vim",
                ft = "typst",
                lazy = true,
        },
}
