-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }
vim.keymap.set("v", "p", '"_dP', opts) -- this is kind of important one, when you yank and then paste on visual it allows you to keep what you originaly yanked instead of replacing it with what was in selection
