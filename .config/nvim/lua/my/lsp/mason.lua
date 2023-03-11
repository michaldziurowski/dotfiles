require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "gopls", "golangci_lint_ls", "tsserver", "lua_ls", "html", "pyright" },
})

local opts = {
    on_attach = require("my.lsp.handlers").on_attach,
    capabilities = require("my.lsp.handlers").capabilities,
}

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup(opts)
    end,

        ["gopls"] = function()
        local gopls_opts = vim.tbl_deep_extend("force", {
            filetypes = { "go", "gomod", "gowork", "gotmpl", "html" },
            settings = {
                gopls = {
                    analyses = {
                        nilness = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true,
                    },
                    experimentalPostfixCompletions = true,
                    gofumpt = true,
                    staticcheck = true,
                    usePlaceholders = true,
                    templateExtensions = { "html" },
                },
            }
        }, opts)
        require("lspconfig")["gopls"].setup(gopls_opts)
    end,
}
