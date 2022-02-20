call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'morhetz/gruvbox' " theme
Plug 'doums/darcula' " theme
Plug 'nvim-lua/plenary.nvim' " required by telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'rafamadriz/friendly-snippets'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ryanoasis/vim-devicons' " this has to be last one
call plug#end()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menu,menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

colorscheme gruvbox
"colorscheme darcula
set termguicolors " recommended by colorscheme to use truecolors (colors more vivid)

set encoding=utf8

set number relativenumber " show relative numbers but in current row show actual row number instead of 0
set iskeyword+=- " treat - as a part of word  the same as _ so eg this-id will be a word userful for selections

set hidden " this is needed because if this is not enabled some functions which open new window (e.g. go to implementation) throw error if current buffer is unsaved

set tabstop=4 " tab should equal 4 spaces
set shiftwidth=4
set expandtab " change tab to spaces

set so=999 " this sets scrolloff to big number which results in vim trying to position cursor in the middle of the screen (verticaly)

set autowrite " writes the content authomatically if :make is called - vim-go uses this to write on test or build

let mapleader = " "

" Find files using Telescope command-line sugar.
nnoremap <leader>fa <cmd>lua require('findall').find_all(require('telescope.themes').get_dropdown({}))<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fif <cmd>Telescope live_grep<cr>
nnoremap <leader>e <cmd>Telescope file_browser<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>

" vim-go settings
let g:go_list_type = "quickfix"

lua require("nvim-tree-cfg")
lua require("lsp-config")
