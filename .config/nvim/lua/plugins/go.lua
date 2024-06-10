return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = false,
              semanticTokens = true,
            },
          },
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",

    opts = function(_, opts)
      local nls = require("null-ls")
      local sourcesWithoutGoFormatting = {}

      for _, v in ipairs(opts.sources) do
        if v ~= nls.builtins.formatting.gofumpt and v ~= nls.builtins.formatting.goimports then
          vim.list_extend(sourcesWithoutGoFormatting, { v })
        end
      end

      opts.sources = sourcesWithoutGoFormatting
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- removed gofumpt
        go = { "goimports" },
      },
    },
  },
}
