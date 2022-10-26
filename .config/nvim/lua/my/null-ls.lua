require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.jq,
        require("null-ls").builtins.formatting.prettier
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({async=false})' ]]
        end
    end,
})
