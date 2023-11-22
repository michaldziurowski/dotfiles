return {
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "warm",
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
