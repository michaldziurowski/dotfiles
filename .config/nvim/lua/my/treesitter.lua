require("nvim-treesitter.configs").setup {
    ensure_installed = {"bash", "go", "gomod", "graphql", "html", "hcl", "javascript", "json", "lua", "make", "markdown", "typescript", "yaml"},
    highlight = {enable = true, additional_vim_regex_hihlighting = false}
}
