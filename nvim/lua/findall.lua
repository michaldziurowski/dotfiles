local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local make_entry = require "telescope.make_entry"
local conf = require("telescope.config").values

local M = {}

local _callable_obj = function()
    local obj = {}

    obj.__index = obj
    obj.__call = function(t, ...) return t:_find(...) end

    obj.close = function() end

    return obj
end

local CombinedFinder = _callable_obj()

function CombinedFinder:new(opts)
    opts = opts or {}

    local obj = setmetatable({
        entry_maker = opts.entry_maker or make_entry.gen_from_string,
        finders = opts.finders or {}
    }, self)

    return obj
end

function CombinedFinder:_find(prompt, process_result, process_complete)
    for _, finder in ipairs(self.finders) do finder(prompt, process_result, function() end) end

    process_complete()
end

M.find_all = function(opts)
    local find_command = (function()
        if opts.find_command then
            return opts.find_command
        elseif 1 == vim.fn.executable "fdfind" then
            return {"fdfind", "--type", "f"}
        end
    end)()

    if not find_command then
        print("You need to install fd (called fdfind in ubuntu).")
        return
    end

    local command = find_command[1]
    local hidden = opts.hidden
    local no_ignore = opts.no_ignore
    local follow = opts.follow
    local search_dirs = opts.search_dirs

    if search_dirs then for k, v in pairs(search_dirs) do search_dirs[k] = vim.fn.expand(v) end end

    if command == "fdfind" then
        if hidden then table.insert(find_command, "--hidden") end
        if no_ignore then table.insert(find_command, "--no-ignore") end
        if follow then table.insert(find_command, "-L") end
        if search_dirs then
            table.insert(find_command, ".")
            for _, v in pairs(search_dirs) do table.insert(find_command, v) end
        end
    end

    if opts.cwd then opts.cwd = vim.fn.expand(opts.cwd) end

    opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

    local myactions = finders.new_table {
        results = {"super duper", "pupper super"},
        entry_maker = function(entry)
            return {value = entry, display = entry, ordinal = entry, custom_action = 'buffers'}
        end
    }

    local ffiles = finders.new_oneshot_job(find_command, opts)

    pickers.new(opts, {
        prompt_title = "Find All",
        finder = CombinedFinder:new({finders = {myactions, ffiles}}),
        sorter = conf.file_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace_if(function()
                return action_state.get_selected_entry().custom_action ~= nil
            end, function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                print(vim.inspect(selection))
                vim.cmd(selection.custom_action)
                vim.api.nvim_put({selection.value}, "", false, true)
            end)
            return true
        end
    }):find()
end

return M
