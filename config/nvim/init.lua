-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    -- Useful plugin to show you pending keybinds.
    { "folke/which-key.nvim", opts = {} },

    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },

    { import = "plugins" },
}, {})

require("config.options")
require("config.keymaps")
require("config.autocmds")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = vim.schedule_wrap(function()
        vim.cmd("Neotree show")
    end),
})
