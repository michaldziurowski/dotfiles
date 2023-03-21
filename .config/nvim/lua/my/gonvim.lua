require('go').setup({
    gofmt = "gopls",
    lsp_gofumpt = false,
    dap_debug_gui = {
        layouts = {
            {
                elements = {
                    "scopes",
                },
                size = 0.3,
                position = "right"
            },
            {
                elements = {
                    "repl",
                    "breakpoints"
                },
                size = 0.3,
                position = "bottom",
            },
        },
    },
})

-- Run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require('go.format').goimport()
    end,
    group = format_sync_grp,
})
