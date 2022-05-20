local module = {}

function module.testMethodUnderCursor()
    local currentDirPath = vim.api.nvim_exec("echo expand('%:p:h')", true)
    local currentMethodName = vim.api.nvim_exec("echo expand('<cword>')", true)
    local command = "sp | te (cd " .. currentDirPath  .. " && go test --run " .. currentMethodName .. ")"
    vim.api.nvim_exec(command, true)
end

function module.testPackageUnderCursor()
    local currentDirPath = vim.api.nvim_exec("echo expand('%:p:h')", true)
    local command = "sp | te (cd " .. currentDirPath  .. " && go test " .. currentDirPath .. ")"
    vim.api.nvim_exec(command, true)
end


return module
