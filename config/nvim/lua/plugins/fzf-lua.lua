return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        -- optional: use fzf native binary for speed
        ---profile = "fzf-native",

        -- example defaults
        files = {
          prompt = "Files❯ ",
        },
        live_grep = {
          prompt = "Rg❯ ",
        },
      })
    end,
  },
}

