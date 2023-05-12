-- get neotest namespace (api call creates or returns namespace)
require("neotest").setup({
    -- your neotest config here
    adapters = {
        require("neotest-go"),
    },
    summary = {
        enabled = true,
        follow = true,
        expand_errors = true
    },
    diagnostic = {
        enabled = true
    },
    quickfix = {
        enabled = false
    },
    output = {
        enabled = true
    }
})
