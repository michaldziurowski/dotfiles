local colorscheme = "everforest"

vim.g.everforest_background = "medium"
vim.g.everforest_better_performance = 1

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
