return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = false,
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
      local sourcesWithoutGoFumpt = {}

      for _, v in ipairs(opts.sources) do
        if v ~= nls.builtins.formatting.gofumpt then
          vim.list_extend(sourcesWithoutGoFumpt, { v })
        end
      end

      opts.sources = sourcesWithoutGoFumpt
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
