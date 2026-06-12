return {
        {
                'nvim-treesitter/nvim-treesitter',
                build = ':TSUpdate',
                opts = {
                        ensure_installed = { 'bash', 'c', 'diff', 'html', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
                        highlight = { enable = true },
                        indent = { enable = true },
                },
        },
        { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require("nvim-autopairs").setup({}) end },
}
