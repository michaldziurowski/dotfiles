-- get neotest namespace (api call creates or returns namespace)
require("neotest").setup({
    -- your neotest config here
    adapters = {
        require("neotest-go"),
    },
    summary = {
        enabled = true
    },
    diagnostic = {
        enabled = false
    },
    output = {
        enabled = true
    }
})
