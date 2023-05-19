-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

keymap("v", "p", '"_dP', opts) -- this is kind of important one, when you yank and then paste on visual it allows you to keep what you originaly yanked instead of replacing it with what was in selection

keymap("n", "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", opts)
-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
local term_opts = { noremap = true, silent = true }
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true, desc = "[f]ind [f]iles" })
keymap("n", "<leader>fif", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true, desc = "[f]ind [i]n [f]iles" })
keymap("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>",
{ noremap = true, silent = true, desc = "[f]ind [r]eferences" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true, desc = "[f]ind [b]uffers" })

-- NvimTree
keymap("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", { noremap = true, silent = true, desc = "[e]xpand nvim tree" })

-- My Go keymaps
keymap("n", "<leader>tm", "<cmd>lua require('neotest').run.run()<cr>",
{ noremap = true, silent = true, desc = "[t]est [m]ethod" })
keymap("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
{ noremap = true, silent = true, desc = "[t]est [f]ile" })

-- Debugging
keymap("n", "<F5>", "<cmd>GoDebug<cr>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",{ noremap = true, silent = true, desc = "toggle [b]reakpoint" })
keymap("n", "<leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",{ noremap = true, silent = true, desc = "toggle [B]reakpoint with condition" })
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>",{ noremap = true, silent = true, desc = "open [d]ebug [r]epl" })
