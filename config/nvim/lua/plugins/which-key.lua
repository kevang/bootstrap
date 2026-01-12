return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")

            wk.setup({
                sort = { "alphanum" },
            })

            -- Normal mode leader groups
            wk.add({
                { "<leader>b", group = "[B]uffer Management" }, -- buffer management
                -- { "<leader>c", group = "[C]ode" }, -- code actions, etc
                -- { "<leader>d", group = "[D]ocument" }, -- document related commands
                { "<leader>f", group = "[F]uzzy Find" }, -- fuzzy searces
                -- { "<leader>g", group = "[G]it" }, -- git commands
                { "<leader>h", group = "Git [H]unk" }, -- git hunk navigation
                -- { "<leader>r", group = "[R]ename" }, -- LSP rename
                -- { "<leader>t", group = "[T]oggle" }, -- toggles
                -- { "<leader>W", group = "[W]orkspace" }, -- workspace management
                { "<leader>x", group = "Diagnostics" }, -- LSP diagnostics
                { "<leader>w", group = "Save [w]indow" }, -- LSP diagnostics
            }, { mode = "n" })

            -- Visual mode leader groups (avoid conflicts with comment mappings)
            wk.add({
                { "<leader>h", group = "Git [H]unk" }, -- visual selection hunk actions
            }, { mode = "v" })
        end,
    },
}
