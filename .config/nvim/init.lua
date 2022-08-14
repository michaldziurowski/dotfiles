require "my.options"
require "my.keymaps"
require "my.plugins"
require "my.colorscheme"
require "my.cmp"
require "my.lsp"
require "my.nvim-tree"
require "my.treesitter"
require "my.autopairs"
require "my.nvim-lightbulb"
require "my.lualine"
require "my.dap"

-- move it somewhere
vim.cmd([[
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua require("my.go-extensions").goimports(1000)
]])


