vim.opt.termguicolors = true

return {
    {
        "akinsho/bufferline.nvim",
        event = "BufReadPost", -- load once a buffer is opened
        keys = {
            { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
            { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
        },
        opts = {
            options = {
                hover = {
                    enabled = true,
                    delay = 150,
                    reveal = { "close" },
                },
            },
        },
    },
}
