-- [[ Keymaps ]]
--  see `:help vim.keymap.set()`

-- diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "exit terminal mode" })

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "open fil[e] tree", silent = true })

-- windows
vim.keymap.set("n", "<M-h>", "<c-w>h", { desc = "move focus to the left window" })
vim.keymap.set("n", "<M-l>", "<c-w>l", { desc = "move focus to the right window" })
vim.keymap.set("n", "<M-j>", "<c-w>j", { desc = "move focus to the lower window" })
vim.keymap.set("n", "<M-k>", "<c-w>k", { desc = "move focus to the upper window" })

vim.keymap.set("n", "<M-s-h>", "<c-w>H", { desc = "move window to the left" })
vim.keymap.set("n", "<M-s-l>", "<c-w>L", { desc = "move window to the right" })
vim.keymap.set("n", "<M-s-j>", "<c-w>J", { desc = "move window to the lower" })
vim.keymap.set("n", "<M-s-k>", "<c-w>K", { desc = "move window to the upper" })

-- debugging
vim.keymap.set("n", "<leader>d", "", { desc = "[D]ebug" })
vim.keymap.set("n", "<leader>dc", function()
        require("dap").continue()
end, { desc = "Start/[C]ontinue Execution" })

vim.keymap.set("n", "<leader>dn", function()
        require("dap").step_over()
end, { desc = "[N]ext Line" })

vim.keymap.set("n", "<leader>ds", function()
        require("dap").step_into()
end, { desc = "Step into" })

vim.keymap.set("n", "<leader>dS", function()
        require("dap").step_out()
end, { desc = "Step out" })

vim.keymap.set("n", "<leader>dr", function()
        require("dap").repl.open()
end, { desc = "Open [R]EPL (command line interface)" })

vim.keymap.set("n", "<leader>dl", function()
        require("dap").run_last()
end, { desc = "Rerun [L]ast Debug Configuration" })

vim.keymap.set("n", "<leader>du", function()
        require("dapui").toggle()
end, { desc = "Toggle debug [U]I panel" })

-- Breakpoints
vim.keymap.set("n", "<leader>db", function()
        require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint at Current Line" })

vim.keymap.set("n", "<leader>dB", function()
        require("dap").set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "Add Conditional Breakpoint" })

-- Other
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle Line [W]rap" })
vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[F]ormat buffer" })

-- I have binding for altgr+n -> : and altgr+w -> [ . i cant type :w fast because of that. this command fixes it
vim.cmd([[cnoreabbrev <expr> [ getcmdtype() ==# ':' && getcmdline() ==# '[' ? 'w' : '[']])
