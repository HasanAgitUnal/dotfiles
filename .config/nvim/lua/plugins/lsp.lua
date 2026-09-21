return {
        --[[ LSP Plugins & Autocompletion ]]
        {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
        },

        {
                "neovim/nvim-lspconfig",
                dependencies = {
                        { "mason-org/mason.nvim", opts = {} },
                        "mason-org/mason-lspconfig.nvim",
                        "WhoIsSethDaniel/mason-tool-installer.nvim",
                        { "j-hui/fidget.nvim", opts = {} },
                        --[[ 
                        {
                                'saghen/blink.cmp',
                                version = '*',
                                build = function() require('blink.cmp').build():wait(60000) end,
                                ...
                        }
                        --]]

                        {
                                "hrsh7th/nvim-cmp",
                                dependencies = {
                                        "hrsh7th/cmp-nvim-lsp",
                                        "hrsh7th/cmp-buffer",
                                        "hrsh7th/cmp-path",
                                },
                                config = function()
                                        local cmp = require("cmp")
                                        cmp.setup({
                                                snippet = {
                                                        expand = function(args)
                                                                vim.snippet.expand(args.body)
                                                        end,
                                                },
                                                mapping = cmp.mapping.preset.insert({
                                                        ["<A-CR>"] = cmp.mapping.confirm({ select = true }),
                                                        ["<Tab>"] = cmp.mapping.select_next_item(),
                                                        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                                                        ["<A-Space>"] = cmp.mapping.complete(),
                                                }),
                                                sources = cmp.config.sources({
                                                        { name = "nvim_lsp" },
                                                        { name = "buffer" },
                                                        { name = "path" },
                                                }),
                                                window = {
                                                        completion = {
                                                                border = "none",
                                                                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
                                                        },
                                                        documentation = {
                                                                border = "none",
                                                                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
                                                        },
                                                },
                                        })
                                end,
                        },
                },
                config = function()
                        vim.api.nvim_create_autocmd("LspAttach", {
                                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                                callback = function(event)
                                        local map = function(keys, func, desc, mode)
                                                mode = mode or "n"
                                                vim.keymap.set(
                                                        mode,
                                                        keys,
                                                        func,
                                                        { buffer = event.buf, desc = "LSP: " .. desc }
                                                )
                                        end
                                        map("<leader>gln", vim.lsp.buf.rename, "[R]e[n]ame")
                                        map(
                                                "<leader>gla",
                                                vim.lsp.buf.code_action,
                                                "[G]oto Code [A]ction",
                                                { "n", "x" }
                                        )
                                        map(
                                                "<leader>glr",
                                                require("telescope.builtin").lsp_references,
                                                "[G]oto [R]eferences"
                                        )
                                        map(
                                                "<leader>gli",
                                                require("telescope.builtin").lsp_implementations,
                                                "[G]oto [I]mplementation"
                                        )
                                        map(
                                                "<leader>gld",
                                                require("telescope.builtin").lsp_definitions,
                                                "[G]oto [D]efinition"
                                        )
                                        map("<leader>glD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                                        map(
                                                "<leader>glO",
                                                require("telescope.builtin").lsp_document_symbols,
                                                "Open Document Symbols"
                                        )
                                        map(
                                                "<leader>glW",
                                                require("telescope.builtin").lsp_dynamic_workspace_symbols,
                                                "Open Workspace Symbols"
                                        )

                                        map(
                                                "<leader>gly",
                                                require("telescope.builtin").lsp_type_definitions,
                                                "[G]oto T[y]pe Definition"
                                        )

                                        if client and client.name == "texlab" then
                                                map(
                                                        "<leader>gle",
                                                        "<cmd>TexlabFindEnvironments<CR>",
                                                        "TexLab [E]nvironments"
                                                )
                                                map(
                                                        "<leader>glc",
                                                        "<cmd>TexlabChangeEnvironment<CR>",
                                                        "TexLab [C]hange Environment"
                                                )
                                                map(
                                                        "<leader>glx",
                                                        "<cmd>TexlabCleanAuxiliary<CR>",
                                                        "TexLab Clean Au[x]"
                                                )
                                                map(
                                                        "<leader>glC",
                                                        "<cmd>TexlabCleanArtifacts<CR>",
                                                        "TexLab Clean Artifacts"
                                                )
                                                map(
                                                        "<leader>glg",
                                                        "<cmd>TexlabDependencyGraph<CR>",
                                                        "TexLab Dependency [G]raph"
                                                )
                                        end

                                        map("<leader>lt", "<cmd>VimtexTocOpen<CR>", "Vimtex: TOC")

                                        local function client_supports_method(client, method, bufnr)
                                                if vim.fn.has("nvim-0.11") == 1 then
                                                        return client:supports_method(method, bufnr)
                                                else
                                                        return client.supports_method(method, { bufnr = bufnr })
                                                end
                                        end

                                        local client = vim.lsp.get_client_by_id(event.data.client_id)
                                        if
                                                client
                                                and client_supports_method(
                                                        client,
                                                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                                                        event.buf
                                                )
                                        then
                                                local highlight_augroup = vim.api.nvim_create_augroup(
                                                        "kickstart-lsp-highlight",
                                                        { clear = false }
                                                )
                                                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                                                        buffer = event.buf,
                                                        group = highlight_augroup,
                                                        callback = vim.lsp.buf.document_highlight,
                                                })
                                                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                                        buffer = event.buf,
                                                        group = highlight_augroup,
                                                        callback = vim.lsp.buf.clear_references,
                                                })
                                        end
                                end,
                        })

                        -- Diagnostic Config
                        vim.diagnostic.config({
                                severity_sort = true,
                                float = { border = "rounded", source = "if_many" },
                                underline = { severity = vim.diagnostic.severity.ERROR },
                                virtual_text = true,
                                signs = vim.g.have_nerd_font
                                                and {
                                                        text = {
                                                                [vim.diagnostic.severity.ERROR] = "󰅚 ",
                                                                [vim.diagnostic.severity.WARN] = "󰀪 ",
                                                                [vim.diagnostic.severity.INFO] = "󰋽 ",
                                                                [vim.diagnostic.severity.HINT] = "󰌶 ",
                                                        },
                                                }
                                        or {},
                        })

                        local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
                                rust_analyzer = {
                                        cmd = { "rust-analyzer" },
                                        filetypes = { "rust" },
                                        single_file_support = true,
                                },
                                lua_ls = {
                                        cmd = { "lua-language-server" },
                                        filetypes = { "lua" },
                                        single_file_support = true,
                                },
                                texlab = {
                                        filetypes = { "tex", "plaintex", "bib" },
                                        single_file_support = true,
                                        settings = {
                                                texlab = {
                                                        chktex = {
                                                                onOpenAndSave = true,
                                                                onEdit = false,
                                                        },
                                                        diagnosticsDelay = 300,
                                                        latexFormatter = "latexindent",
                                                        latexindent = {
                                                                modifyLineBreaks = false,
                                                        },
                                                },
                                        },
                                },
                        }

                        local ensure_installed = {}
                        for server_name, _ in pairs(servers or {}) do
                                if server_name ~= "clangd" then
                                        table.insert(ensure_installed, server_name)
                                end
                        end
                        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
                        require("mason-lspconfig").setup({
                                handlers = {
                                        function(server_name)
                                                local server = servers[server_name] or {}
                                                server.capabilities = vim.tbl_deep_extend(
                                                        "force",
                                                        {},
                                                        capabilities,
                                                        server.capabilities or {}
                                                )
                                                require("lspconfig")[server_name].setup(server)
                                        end,
                                },
                        })
                end,
        },
}
