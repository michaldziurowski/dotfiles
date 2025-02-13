-- return {
--   {
--     "olimorris/onedarkpro.nvim",
--     priority = 1000, -- Ensure it loads first
--   },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "onedark",
--     },
--   },
-- }
-- taken from https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua warm palette
local c = {
  black = "#191a1c",
  bg0 = "#2c2d30",
  bg1 = "#35373b",
  bg2 = "#3e4045",
  bg3 = "#404247",
  bg_d = "#242628",
  bg_blue = "#79b7eb",
  bg_yellow = "#e6cfa1",
  fg = "#b1b4b9",
  purple = "#c27fd7",
  green = "#99bc80",
  orange = "#c99a6e",
  blue = "#68aee8",
  yellow = "#dfbe81",
  cyan = "#5fafb9",
  red = "#e16d77",
  grey = "#646568",
  light_grey = "#8b8d91",
  dark_cyan = "#316a71",
  dark_red = "#914141",
  dark_yellow = "#8c6724",
  dark_purple = "#854897",
  diff_add = "#32352f",
  diff_delete = "#342f2f",
  diff_change = "#203444",
  diff_text = "#32526c",
}
return {
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "warm",
      highlights = {
        -- change colors of neotree drawer
        NeoTreeWinSeparator = { fg = c.bg3, bg = c.bg0 },
        NeoTreeNormal = { fg = c.fg, bg = c.bg0 },
        NeoTreeNormalNC = { fg = c.fg, bg = c.bg0 },
        NeoTreeEndOfBuffer = { fg = c.bg0, bg = c.bg0 },
        WinSeparator = { fg = c.fg, bg = c.bg0 },
        FloatBorder = { fg = c.fg, bg = c.bg0 },
        MiniDiffOverAdd = { fg = c.fg, bg = "#537a55" },
        MiniDiffOverDelete = { fg = c.fg, bg = "#b5766d" },
        MiniDiffOverChange = { fg = c.fg, bg = "#618764" },
        MiniDiffOverContext = { fg = c.fg, bg = "#b5766d" },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
-- return { -- not bad
--   "savq/melange-nvim",
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "melange",
--     },
--   },
-- }
-- return { -- this one seems fine
--   {
--     "AlexvZyl/nordic.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("nordic").load()
--     end,
--   },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "nordic",
--     },
--   },
-- }
