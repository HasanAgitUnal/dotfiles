-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
        local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
        if vim.v.shell_error ~= 0 then
                error('Error cloning lazy.nvim:\n' .. out)
        end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
require('lazy').setup({
        {
                "nvim-tree/nvim-tree.lua",
                config = function()
                        require("nvim-tree").setup({
                                filesystem_watchers = { enable = true },
                                actions = { open_file = { quit_on_open = true } }
                        })
                end
        },

        'NMAC427/guess-indent.nvim',

        -- See `:help gitsigns` to understand what the configuration keys do
        {
                'lewis6991/gitsigns.nvim',
                opts = {
                        signs = {
                                add = { text = '+' },
                                change = { text = '*' },
                                delete = { text = '-' },
                                topdelete = { text = '‾' },
                                changedelete = { text = '*' },
                        },
                        signs_staged = {
                                add = { text = '>' },
                                delete = { text = '<' },
                                topdelete = { text = '^' },
                                changedelete = { text = '<' },
                        },

                },
        },

        {
                'folke/which-key.nvim',
                event = 'VimEnter',
                opts = {
                        -- delay between pressing a key and opening which-key (milliseconds)
                        -- this setting is independent of vim.o.timeoutlen
                        delay = 200,
                        icons = {
                                mappings = vim.g.have_nerd_font,
                                keys = vim.g.have_nerd_font and {} or {
                                        Up = '<Up> ',
                                        Down = '<Down> ',
                                        Left = '<Left> ',
                                        Right = '<Right> ',
                                        C = '<C-…> ',
                                        M = '<M-…> ',
                                        D = '<D-…> ',
                                        S = '<S-…> ',
                                        CR = '<CR> ',
                                        Esc = '<Esc> ',
                                        ScrollWheelDown = '<ScrollWheelDown> ',
                                        ScrollWheelUp = '<ScrollWheelUp> ',
                                        NL = '<NL> ',
                                        BS = '<BS> ',
                                        Space = '<Space> ',
                                        Tab = '<Tab> ',
                                        F1 = '<F1>',
                                        F2 = '<F2>',
                                        F3 = '<F3>',
                                        F4 = '<F4>',
                                        F5 = '<F5>',
                                        F6 = '<F6>',
                                        F7 = '<F7>',
                                        F8 = '<F8>',
                                        F9 = '<F9>',
                                        F10 = '<F10>',
                                        F11 = '<F11>',
                                        F12 = '<F12>',
                                },
                        },

                        spec = {
                                { '<leader>s', group = '[S]earch' },
                                { '<leader>t', group = '[T]oggle' },
                                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
                        },
                },
        },

        { -- Fuzzy Finder (files, lsp, etc)
                'nvim-telescope/telescope.nvim',
                event = 'VimEnter',
                dependencies = {
                        'nvim-lua/plenary.nvim',
                        { -- If encountering errors, see telescope-fzf-native README for installation instructions
                                'nvim-telescope/telescope-fzf-native.nvim',
                                build = 'make',
                                cond = function()
                                        return vim.fn.executable 'make' == 1
                                end,
                        },
                        { 'nvim-telescope/telescope-ui-select.nvim' },

                        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
                },
                config = function()
                        -- [[ Configure Telescope ]]
                        -- See `:help telescope` and `:help telescope.setup()`
                        require('telescope').setup {
                                --  All the info you're looking for is in `:help telescope.setup()`
                                --
                                -- defaults = {
                                        --   mappings = {
                                                --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                                                --   },
                                                -- },
                                                -- pickers = {}
                                                extensions = {
                                                        ['ui-select'] = {
                                                                require('telescope.themes').get_dropdown(),
                                                        },
                                                },
                                        }

                                        -- Enable Telescope extensions if they are installed
                                        pcall(require('telescope').load_extension, 'projects')
                                        pcall(require('telescope').load_extension, 'fzf')
                                        pcall(require('telescope').load_extension, 'ui-select')

                                        -- See `:help telescope.builtin`
                                        local builtin = require 'telescope.builtin'
                                        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
                                        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
                                        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
                                        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
                                        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
                                        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
                                        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
                                        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
                                        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
                                        vim.keymap.set('n', '<leader>sp', ":Telescope projects<CR>", { desc = '[S]earch [P]rojects' })
                                        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

                                        vim.keymap.set('n', '<leader>/', function()
                                                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                                                        winblend = 10
                                                })
                                        end, { desc = '[/] Fuzzily search in current buffer' })

                                        --  See `:help telescope.builtin.live_grep()` for information about particular keys
                                        vim.keymap.set('n', '<leader>s/', function()
                                                builtin.live_grep {
                                                        grep_open_files = true,
                                                        prompt_title = 'Live Grep in Open Files',
                                                }
                                        end, { desc = '[S]earch [/] in Open Files' })

                                        vim.keymap.set('n', '<leader>sn', function()
                                                builtin.find_files { cwd = vim.fn.stdpath 'config' }
                                        end, { desc = '[S]earch [N]eovim files' })
                                end,
                        },

                        -- LSP Plugins
                        {
                                'folke/lazydev.nvim',
                                ft = 'lua',
                                opts = {
                                        library = {
                                                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                                        },
                                },
                        },
                        {
                                'neovim/nvim-lspconfig',
                                dependencies = {
                                        -- Automatically install LSPs and related tools to stdpath for Neovim
                                        { 'mason-org/mason.nvim', opts = {} },
                                        'mason-org/mason-lspconfig.nvim',
                                        'WhoIsSethDaniel/mason-tool-installer.nvim',

                                        { 'j-hui/fidget.nvim', opts = {} },

                                        {
                                                'saghen/blink.cmp',
                                                version = '*',
                                                build = function() require('blink.cmp').build():wait(60000) end,
                                                opts = {
                                                        keymap = {
                                                                preset = 'none',
                                                                ['<A-CR>'] = { 'select_and_accept', 'fallback' },
                                                                ['<Tab>'] = { 'select_next', 'fallback' },
                                                                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                                                                ['<A-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                                                        },
                                                        cmdline = {
                                                                enabled = true,
                                                                keymap = {
                                                                        preset = 'none',
                                                                        ['<A-CR>'] = { 'select_and_accept', 'fallback' },
                                                                        ['<Tab>'] = { 'select_next', 'fallback' },
                                                                        ['<S-Tab>'] = { 'select_prev', 'fallback' },
                                                                        ['<A-Space>'] = { 'show', 'fallback' },
                                                                },
                                                        },
                                                        appearance = {
                                                                use_nvim_cmp_as_default = true,
                                                                nerd_font_variant = 'mono'
                                                        },
                                                        completion = {
                                                                menu = { 
                                                                        border = 'none',
                                                                        draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } } }
                                                                },
                                                                documentation = { window = { border = 'single' }, auto_show = true },
                                                                trigger = { prefetch_on_insert = false },
                                                                list = { selection = { preselect = false, auto_insert = true } },
                                                        },
                                                        sources = {
                                                                default = { 'lsp', 'path', 'buffer' },
                                                        },
                                                        signature = { enabled = true, window = { border = 'single' } }
                                                }
                                        },
                                        'saghen/blink.lib'
                                },
                                config = function()
                                        vim.api.nvim_create_autocmd('LspAttach', {
                                                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                                                callback = function(event)
                                                        local map = function(keys, func, desc, mode)
                                                                mode = mode or 'n'
                                                                vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                                                        end

                                                        -- Rename the variable under your cursor.
                                                        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                                                        -- Execute a code action, usually your cursor needs to be on top of an error
                                                        -- or a suggestion from your LSP for this to activate.
                                                        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

                                                        -- Find references for the word under your cursor.
                                                        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                                                        -- Jump to the implementation of the word under your cursor.
                                                        --  Useful when your language has ways of declaring types without an actual implementation.
                                                        map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                                                        -- Jump to the definition of the word under your cursor.
                                                        --  This is where a variable was first declared, or where a function is defined, etc.
                                                        --  To jump back, press <C-t>.
                                                        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                                                        -- WARN: This is not Goto Definition, this is Goto Declaration.
                                                        --  For example, in C this would take you to the header.
                                                        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                                                        -- Fuzzy find all the symbols in your current document.
                                                        --  Symbols are things like variables, functions, types, etc.
                                                        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

                                                        -- Fuzzy find all the symbols in your current workspace.
                                                        --  Similar to document symbols, except searches over your entire project.
                                                        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

                                                        -- Jump to the type of the word under your cursor.
                                                        --  Useful when you're not sure what type a variable is and you want to see
                                                        --  the definition of its *type*, not where it was *defined*.
                                                        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                                                        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                                                        ---@param client vim.lsp.Client
                                                        ---@param method vim.lsp.protocol.Method
                                                        ---@param bufnr? integer some lsp support methods only in specific files
                                                        ---@return boolean
                                                        local function client_supports_method(client, method, bufnr)
                                                                if vim.fn.has 'nvim-0.11' == 1 then
                                                                        return client:supports_method(method, bufnr)
                                                                else
                                                                        return client.supports_method(method, { bufnr = bufnr })
                                                                end
                                                        end

                                                        -- The following two autocommands are used to highlight references of the
                                                        -- word under your cursor when your cursor rests there for a little while.
                                                        --    See `:help CursorHold` for information about when this is executed
                                                        --
                                                        -- When you move your cursor, the highlights will be cleared (the second autocommand).
                                                        local client = vim.lsp.get_client_by_id(event.data.client_id)
                                                        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                                                                local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                                                                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                                                                        buffer = event.buf,
                                                                        group = highlight_augroup,
                                                                        callback = vim.lsp.buf.document_highlight,
                                                                })

                                                                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                                                                        buffer = event.buf,
                                                                        group = highlight_augroup,
                                                                        callback = vim.lsp.buf.clear_references,
                                                                })

                                                                vim.api.nvim_create_autocmd('LspDetach', {
                                                                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                                                                        callback = function(event2)
                                                                                vim.lsp.buf.clear_references()
                                                                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                                                                        end,
                                                                })
                                                        end

                                                        -- The following code creates a keymap to toggle inlay hints in your
                                                        -- code, if the language server you are using supports them
                                                        --
                                                        -- This may be unwanted, since they displace some of your code
                                                        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                                                                map('<leader>th', function()
                                                                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                                                                end, '[T]oggle Inlay [H]ints')
                                                        end
                                                end,
                                        })

                                        -- Diagnostic Config
                                        -- See :help vim.diagnostic.Opts
                                        vim.diagnostic.config {
                                                severity_sort = true,
                                                float = { border = 'rounded', source = 'if_many' },
                                                underline = { severity = vim.diagnostic.severity.ERROR },
                                                signs = vim.g.have_nerd_font and {
                                                        text = {
                                                                [vim.diagnostic.severity.ERROR] = '󰅚 ',
                                                                [vim.diagnostic.severity.WARN] = '󰀪 ',
                                                                [vim.diagnostic.severity.INFO] = '󰋽 ',
                                                                [vim.diagnostic.severity.HINT] = '󰌶 ',
                                                        },
                                                } or {},
                                                virtual_text = {
                                                        source = 'if_many',
                                                        spacing = 2,
                                                        format = function(diagnostic)
                                                                local diagnostic_message = {
                                                                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                                                                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                                                                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                                                                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                                                                }
                                                                return diagnostic_message[diagnostic.severity]
                                                        end,
                                                },
                                        }

                                        -- LSP servers and clients are able to communicate to each other what features they support.
                                        --  By default, Neovim doesn't support everything that is in the LSP specification.
                                        --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
                                        --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
                                        local capabilities = require('blink.cmp').get_lsp_capabilities()

                                        -- Enable the following language servers
                                        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
                                        --
                                        --  Add any additional override configuration in the following tables. Available keys are:
                                        --  - cmd (table): Override the default command used to start the server
                                        --  - filetypes (table): Override the default list of associated filetypes for the server
                                        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
                                        --  - settings (table): Override the default settings passed when initializing the server.
                                        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
                                        local servers = {
                                                clangd = {
                                                        cmd = {
                                                                "clangd",
                                                                "--clang-tidy",
                                                                "--background-index",
                                                                "--completion-style=detailed",
                                                        },
                                                        filetypes = { "c", "cpp", "objc", "objcpp" },
                                                        single_file_support = true,
                                                },
                                                -- gopls = {},
                                                -- pyright = {},
                                                -- rust_analyzer = {},
                                                -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                                                --
                                                -- Some languages (like typescript) have entire language plugins that can be useful:
                                                --    https://github.com/pmizio/typescript-tools.nvim
                                                --
                                                -- But for many setups, the LSP (`ts_ls`) will work just fine
                                                -- ts_ls = {},
                                                --

                                                --[[
                                                lua_ls = {
                                                        -- cmd = { ... },
                                                        -- filetypes = { ... },
                                                        -- capabilities = {},
                                                        settings = {
                                                                Lua = {
                                                                        completion = {
                                                                                callSnippet = 'Replace',
                                                                        },
                                                                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                                                                        -- diagnostics = { disable = { 'missing-fields' } },
                                                                },
                                                        },
                                                },
                                                --]]
                                        }

                                        -- Ensure the servers and tools above are installed
                                        --
                                        -- To check the current status of installed tools and/or manually install
                                        -- other tools, you can run
                                        --    :Mason
                                        --
                                        -- You can press `g?` for help in this menu.
                                        --
                                        -- `mason` had to be setup earlier: to configure its options see the
                                        -- `dependencies` table for `nvim-lspconfig` above.
                                        --
                                        -- You can add other tools here that you want Mason to install
                                        -- for you, so that they are available from within Neovim.
                                        --
                                        -- install servers excepting clangd (for termux)
                                        local ensure_installed = {}
                                        for server_name, _ in pairs(servers or {}) do
                                                if server_name ~= "clangd" then
                                                        table.insert(ensure_installed, server_name)
                                                end
                                        end
                                        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

                                        require('mason-lspconfig').setup {
                                                ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                                                automatic_installation = false,
                                                handlers = {
                                                        function(server_name)
                                                                local server = servers[server_name] or {}
                                                                -- This handles overriding only values explicitly passed
                                                                -- by the server configuration above. Useful when disabling
                                                                -- certain features of an LSP (for example, turning off formatting for ts_ls)
                                                                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                                                                require('lspconfig')[server_name].setup(server)
                                                        end,
                                                },
                                        }
                                end,
                        },

                        --{
                        --        "baliestri/aura-theme",
                        --        lazy = false,
                        --        priority = 1000,
                        --        config = function(plugin)
                        --                vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
                        --                vim.cmd([[colorscheme aura-dark]])
                        --        end
                        --},

                        -- Highlight todo, notes, etc in comments
                        { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

                        { -- Collection of various small independent plugins/modules
                                'echasnovski/mini.nvim',
                                config = function()
                                        -- Better Around/Inside textobjects
                                        --
                                        -- Examples:
                                        --  - va)  - [V]isually select [A]round [)]paren
                                        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
                                        --  - ci'  - [C]hange [I]nside [']quote
                                        require('mini.ai').setup { n_lines = 500 }

                                        -- Add/delete/replace surroundings (brackets, quotes, etc.)
                                        --
                                        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
                                        -- - sd'   - [S]urround [D]elete [']quotes
                                        -- - sr)'  - [S]urround [R]eplace [)] [']
                                        require('mini.surround').setup()

                                        --  Check out: https://github.com/echasnovski/mini.nvim
                                        --vim.cmd('hi MiniStatuslineInactive guibg=#6bc7dd guifg=#111117')
                                        --vim.cmd('hi MiniStatuslineFilename guibg=#50ea8c guifg=#111117')
                                        local statusline = require 'mini.statusline'
                                        statusline.setup {
                                                use_icons = vim.g.have_nerd_font,
                                                content = {
                                                        active = function()
                                                                local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
                                                                local filename      = statusline.section_filename({ trunc_width = 140 })
                                                                local location      = statusline.section_location({ trunc_width = 75 })
                                                                local ft            = vim.bo.filetype

                                                                local icon = ''
                                                                if vim.g.have_nerd_font then
                                                                        local ok, devicons = pcall(require, 'nvim-web-devicons')
                                                                        if ok then
                                                                                icon = devicons.get_icon_by_filetype(ft, { default = true }) .. ' '
                                                                        end
                                                                end
                                                                local filetype_str = icon .. ft

                                                                return statusline.combine_groups({
                                                                        { hl = mode_hl,                  strings = { mode } },    
                                                                        { hl = 'MiniStatuslineFilename',  strings = { filename } },
                                                                        '%#MiniStatuslineInactive#%=',
                                                                        { hl = mode_hl,                  strings = { location } }, 
                                                                        { hl = 'MiniStatuslineFilename',  strings = { filetype_str } },
                                                                })
                                                        end,
                                                },
                                        }

                                        statusline.section_location = function()
                                                return '%2l:%-2v'
                                        end

                                        require('mini.base16').setup({
                                                palette = {
                                                        base00 = '#111117',
                                                        base01 = '#171720',
                                                        base02 = '#272740',
                                                        base03 = '#424242',
                                                        base04 = '#a0a0a0',
                                                        base05 = '#e0e0e0',
                                                        base06 = '#f0f0f0',
                                                        base07 = '#ffffff',
                                                        base08 = '#6bc7dd',
                                                        base09 = '#207d8a',
                                                        base0A = '#e1ea8c',
                                                        base0B = '#50ea7b',
                                                        base0C = '#6bc7dd',
                                                        base0D = '#207d8a',
                                                        base0E = '#ee79c6',
                                                        base0F = '#cfcfcf',
                                                }
                                        })

                                end,
                        },
                        {
                                'nvim-treesitter/nvim-treesitter',
                                build = ':TSUpdate',
                                opts = {
                                        ensure_installed = { 'bash', 'c', 'diff', 'html', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
                                        auto_install = false,
                                        highlight = {
                                                enable = true,
                                        },
                                        indent = { enable = true, disable = { 'ruby' } },
                                },
                        },

                        -- require 'kickstart.plugins.debug',
                        -- require 'kickstart.plugins.indent_line',
                        -- require 'kickstart.plugins.lint',
                        -- require 'kickstart.plugins.autopairs',
                        -- require 'kickstart.plugins.neo-tree',
                        -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

                        {
                                "windwp/nvim-autopairs",
                                event = "InsertEnter",
                                config = function()
                                        require("nvim-autopairs").setup({
                                                check_ts = true,
                                                map_bs = true,
                                        })
                                end
                        },

                        {
                                "stevearc/conform.nvim",
                                opts = {
                                        formatters_by_ft = {
                                                c = { "clang-format" },
                                                cpp = { "clang-format" },
                                        },
                                        -- İstediğin zaman format atmak için (otomatik formatı kapalı tutuyoruz)
                                        format_on_save = false,
                                },
                        },

                        {
                                {
                                        "mfussenegger/nvim-dap",
                                        config = function()
                                                local dap = require("dap")

                                                dap.adapters.gdb = {
                                                        type = "executable",
                                                        command = "gdb",
                                                        args = { "-i", "dap" }
                                                }

                                                dap.configurations.c = {
                                                        {
                                                                name = "Launch",
                                                                type = "gdb",
                                                                request = "launch",
                                                                program = function()
                                                                        return vim.fn.input("Program: ", vim.fn.getcwd() .. "/", "file")
                                                                end,
                                                                cwd = "${workspaceFolder}",
                                                                stopAtBeginningOfMainSubprogram = true,
                                                        }
                                                }
                                                dap.configurations.cpp = dap.configurations.c
                                        end
                                },

                                {
                                        "rcarriga/nvim-dap-ui",
                                        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
                                        config = function()
                                                require("dapui").setup()

                                                local dap, dapui = require("dap"), require("dapui")
                                                dap.listeners.after.event_initialized["dapui_config"] = function()
                                                        dapui.open()
                                                end
                                                dap.listeners.before.event_terminated["dapui_config"] = function()
                                                        dapui.close()
                                                end
                                                dap.listeners.before.event_exited["dapui_config"] = function()
                                                        dapui.close()
                                                end
                                        end
                                },

                                {
                                        "theHamsta/nvim-dap-virtual-text",
                                        dependencies = { "mfussenegger/nvim-dap" },
                                        config = function()
                                                require("nvim-dap-virtual-text").setup()
                                        end
                                },
                        },
                        {
                                "ahmedkhalf/project.nvim",
                                config = function()
                                        require("project_nvim").setup({
                                                detection_methods = { "lsp", "pattern" },
                                                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".clang-format", ".project" },

                                                update_focused_file = {
                                                        enable = true,
                                                        update_root = true,
                                                },
                                        })
                                end,
                        },
                        {
                                "epwalsh/obsidian.nvim",
                                version = "*",
                                lazy = true,
                                ft = "markdown",
                                dependencies = { "nvim-lua/plenary.nvim" },
                                opts = {
                                        workspaces = {
                                                {
                                                        name = "vault",
                                                        path = "/home/melon/documents/obsidian/",
                                                },
                                        },
                                        notes_subdir = "notes",
                                        new_notes_location = "notes_subdir",
                                        completion = { nvim_cmp = false, min_chars = 2 },
                                        checkboxes = {
                                                [" "] = { char = " ", hl_group = "ObsidianTodo" },
                                                ["x"] = { char = "x", hl_group = "ObsidianDone" },
                                                ["/"] = { char = "/", hl_group = "ObsidianTilde" },
                                                ["~"] = { char = "~", hl_group = "ObsidianBullet" },
                                                ["!"] = { char = "!", hl_group = "ObsidianImportant" },
                                                [">"] = { char = ">", hl_group = "ObsidianRightArrow" },
                                        },
                                        follow_url_func = function(url)
                                                vim.fn.jobstart({ "xdg-open", url })
                                        end,

                                        ui = { enable = false }, -- Set to false to allow render-markdown to work correctly
                                },
                        },

                        {
                                'MeanderingProgrammer/render-markdown.nvim',
                                dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
                                ft = { "markdown", "obsidian" },
                                opts = {
                                        heading = {
                                                sign = true,
                                                icons = { " ", " ", " ", " ", " ", " " },
                                        },
                                        code = {
                                                sign = false,
                                                width = "block",
                                                right_pad = 1,
                                        },
                                        checkbox = {
                                                enabled = true,
                                                unchecked = { icon = '󰄱 ' },
                                                checked = { icon = '󰄲 ' },
                                                custom = {
                                                        important = { raw = '[!]', rendered = ' ', highlight = 'RenderMarkdownChecked' },
                                                        doing = { raw = '[/]', rendered = ' ', highlight = 'RenderMarkdownCurrent' },
                                                        cancelled = { raw = '[~]', rendered = '󰜺 ', highlight = 'RenderMarkdownUnchecked' },
                                                        postponed = { raw = '[>]', rendered = '󱑂 ', highlight = 'RenderMarkdownChecked' },
                                                },
                                        },
                                },
                        },
                }, {
                        ui = {
                                icons = vim.g.have_nerd_font and {} or {
                                        cmd = '⌘',
                                        config = '🛠',
                                        event = '📅',
                                        ft = '📂',
                                        init = '⚙',
                                        keys = '🗝',
                                        plugin = '🔌',
                                        runtime = '💻',
                                        require = '🌙',
                                        source = '📄',
                                        start = '🚀',
                                        task = '📌',
                                        lazy = '💤 ',
                                },
                        },
                })


