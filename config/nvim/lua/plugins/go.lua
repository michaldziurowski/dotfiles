-- on colorscheme change clear the hihghtlight group for go string so it could take highlight from treesitter (useful if I want to highlight certain strings as html via injections see injections in ~/.config/nvim/queries/go/injections.scm)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "@lsp.type.string.go", {})
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = false,
              semanticTokens = false,
            },
          },
        },
      },
    },
  },
  -- https://github.com/ngalaiko/tree-sitter-go-template
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gotmpl",
      })
    end,
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
      formatters = {
        gotmplfmt = {
          command = "prettier",
          args = function()
            local obj = vim.system({ "npm", "root", "-g" }, { text = true }):wait()
            -- { code = 0, signal = 0, stdout = 'hello', stderr = '' }
            local npmRoot = obj.stdout:gsub("\n$", "")
            -- first the prettier-plugin-go-template has to be installed globally (npm install -g)
            local pluginPath = npmRoot .. "/prettier-plugin-go-template/lib/index.js"
            return { "--plugin=" .. pluginPath, "--parser", "html" }
          end,
        },
      },
      formatters_by_ft = {
        -- removed gofumpt
        go = { "goimports" },
        gotmpl = { "gotmplfmt" },
      },
    },
  },
}
