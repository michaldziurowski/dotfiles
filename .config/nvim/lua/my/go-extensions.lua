local M = {}

function M.testMethodUnderCursor()
    local currentDirPath = vim.api.nvim_exec("echo expand('%:p:h')", true)
    local currentMethodName = vim.api.nvim_exec("echo expand('<cword>')", true)
    local command = "sp | te (cd " .. currentDirPath  .. " && go test --run " .. currentMethodName .. ")"
    vim.api.nvim_exec(command, true)
end

function M.testPackageUnderCursor()
    local currentDirPath = vim.api.nvim_exec("echo expand('%:p:h')", true)
    local command = "sp | te (cd " .. currentDirPath  .. " && go test " .. currentDirPath .. ")"
    vim.api.nvim_exec(command, true)
end

function M.goimports(timeoutms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
end

return M
