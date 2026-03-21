-- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
--
vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
        callback = function()
                vim.hl.on_yank()
        end,
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove highlight after search
augroup('IncSearchHighlight', { clear = true })
autocmd('CmdlineEnter', {
        group = 'IncSearchHighlight',
        pattern = '/,\\?',
        command = [[ :set hlsearch ]],
})
autocmd('CmdlineLeave', {
        group = 'IncSearchHighlight',
        pattern = '/,\\?',
        command = [[ :set nohlsearch ]],
})
