require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "gopls", "golangci_lint_ls", "tsserver", "sumneko_lua", "terraformls" },
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
    -- For example, a handler override for the `rust_analyzer`:
    ["gopls"] = function()
        local gopls_opts = vim.tbl_deep_extend("force", { settings = {
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
            },
        } }, opts)
        require("lspconfig")["gopls"].setup(gopls_opts)
    end,
    ["sumneko_lua"] = function()
        local lua_opts = vim.tbl_deep_extend("force", { settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                },
            },
        } }, opts)
        require("lspconfig")["sumneko_lua"].setup(lua_opts)
    end

}
