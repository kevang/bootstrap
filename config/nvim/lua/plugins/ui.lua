return {
  -- Themes
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "sainnhe/gruvbox-material", priority = 1000, config = true },
  { "sainnhe/everforest", priority = 1000, config = true },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
        path = 2,
      },
    },
  },
}

