-- Automatically install lazy.nvim
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

local plugins = {
    "nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
    "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter

    'sainnhe/everforest',    --colorscheme

    -- cmp plugins
    "hrsh7th/nvim-cmp",         -- The completion plugin
    "hrsh7th/cmp-buffer",       -- buffer completions
    "hrsh7th/cmp-path",         -- path completions
    "hrsh7th/cmp-cmdline",      -- cmdline completions
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",

    -- snippets
    "L3MON4D3/LuaSnip",             --snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use

    -- LSP
    "williamboman/mason.nvim", -- simple to use language server installer
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",   -- enable LSP
    {
        "j-hui/fidget.nvim",   -- spinner for lsp progress
        tag = "legacy",
        event = "LspAttach",
    },

    -- Lightbulb
    {
        'kosayoda/nvim-lightbulb',
        dependencies = 'antoinemadec/FixCursorHold.nvim',
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    -- Nvim tree
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        }
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "nvim-treesitter/playground",

    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
    },

    -- dap - debugger required by go.nvim
    'mfussenegger/nvim-dap',
    -- config for dap ui is done in gonvim.lua setup under dap_debug_gui param
    'rcarriga/nvim-dap-ui',

    -- go.nvim - run GoInstallBinaries after first introduction of this plugin
    'ray-x/go.nvim',
    'ray-x/guihua.lua', -- recommended if need floating window support

    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-go",
        }
    },

    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        },
    },
    -- Null-ls - adapt some stuff to lsp
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    -- git merge conflict resolution
    {
        'akinsho/git-conflict.nvim',
        config = function()
            require('git-conflict').setup()
        end
    },

    -- markdown preview
    { "ellisonleao/glow.nvim" },

    -- auto close html tags
    { "windwp/nvim-ts-autotag" },

    -- show indentiations
    "lukas-reineke/indent-blankline.nvim",

    -- git blame and stuff
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                current_line_blame = true,
                current_line_blame_formatter = '<author_mail>, <author_time:%Y-%m-%d> - <summary>',
            }
        end
    },

    -- git diff display
    { 'sindrets/diffview.nvim',  dependencies = 'nvim-lua/plenary.nvim' },

    -- toggle term
    { 'akinsho/toggleterm.nvim', version = "*",                         config = true },

    -- which key
    {
        {
            "folke/which-key.nvim",
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 500
                require("which-key").setup({
                })
            end,
        },
    },

    -- undotree
    { "mbbill/undotree" },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
}
-- Install your plugins here
require("lazy").setup(plugins)
