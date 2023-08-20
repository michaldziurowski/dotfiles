require("nvim-treesitter.configs").setup {
    ensure_installed = { "bash", "go", "gomod", "graphql", "html", "css", "hcl", "javascript", "json", "lua", "make", "markdown",
        "typescript", "yaml","terraform", "query", "python" },
    highlight = { enable = true, additional_vim_regex_hihlighting = false }
}

