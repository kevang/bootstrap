vim.api.nvim_create_autocmd("VimEnter", {
    callback = vim.schedule_wrap(function()
        vim.cmd("Neotree show")
    end),
})

return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "<leader>e", "<Cmd>Neotree toggle<CR>", desc = "[E]xplorer" },
    },
    opts = {
        close_if_last_window = true,
        window = { position = "left", width = 40 },
        filesystem = {
            follow_current_file = { enabled = false },
            filtered_items = {
                hide_dotfiles = true,
                hide_gitignored = true,
            },
        },
    },
}
