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
Plug 'ryanoasis/vim-devicons' " this has to be last one
call plug#end()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menu,menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

"colorscheme gruvbox
colorscheme darcula
set termguicolors " recommended by colorscheme to use truecolors (colors more vivid)

set encoding=utf8

set number relativenumber " show relative numbers but in current row show actual row number instead of 0
set iskeyword+=- " treat - as a part of word  the same as _ so eg this-id will be a word userful for selections

set hidden " this is needed because if this is not enabled some functions which open new window (e.g. go to implementation) throw error if current buffer is unsaved

set tabstop=4 " tab should equal 4 spaces
set shiftwidth=4
set expandtab " change tab to spaces

set so=999 " this sets scrolloff to big number which results in vim trying to position cursor in the middle of the screen (verticaly)

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>lua require('findall').find_all(require('telescope.themes').get_dropdown({}))<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-e> <cmd>Telescope file_browser<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
vnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>

lua require("lsp-config")
