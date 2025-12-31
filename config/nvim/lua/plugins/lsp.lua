return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- on_attach
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then desc = "LSP: " .. desc end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        nmap("K", vim.lsp.buf.hover, "Hover")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
          vim.lsp.buf.format()
        end, {})
      end

      vim.keymap.set("n", "gd", function()
        require("fzf-lua").lsp_definitions()
      end)
      vim.keymap.set("n", "gr", function()
          require("fzf-lua").lsp_references()
      end)

      require("neodev").setup()
      require("mason").setup()
      require("mason-lspconfig").setup()

      local servers = {
        bashls = {},
        pyright = {},
        yamlls = {},
        jsonls = {
          settings = {
            json = { validate = { enable = true } },
          },
        },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

      mason_lspconfig.setup({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = servers[server_name].filetypes,
          })
        end,
      })
    end,
  },
}

