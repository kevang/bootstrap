-- [[ Basic Keymaps ]]

-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>xe", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>xq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set("n", "<leader>fc", function()
    require("fzf-lua").commands()
end, { desc = "List commands" })

vim.keymap.set("n", "<leader>ff", function()
    require("fzf-lua").files()
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fg", function()
    require("fzf-lua").live_grep()
end, { desc = "Grep text" })

vim.keymap.set("n", "<leader>fb", function()
    require("fzf-lua").buffers()
end, { desc = "List buffers" })

vim.keymap.set("n", "<leader>fr", function()
    require("fzf-lua").oldfiles()
end, { desc = "Recent files" })

vim.keymap.set("n", ";", function()
    require("fzf-lua").command_history()
end, { noremap = true, silent = true })
