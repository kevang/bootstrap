vim.opt.termguicolors = true

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<cr>", { desc = "Cycle to next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<cr>", { desc = "Cycle to previous tab" })
vim.keymap.set("n", "<leader>w", ":BufferLinePickClose<cr>", { desc = "Close current tab" })

return {
    {
        "akinsho/bufferline.nvim",
        options = {
            hover = {
                enabled = true,
                delay = 150,
                reveal = { "close" },
            },
        },
    },
}
