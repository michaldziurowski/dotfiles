local util = require("codecompanion.utils")
local buf_utils = require("codecompanion.utils.buffers")
local config = require("codecompanion.config")

local ChatFileSave = {}

ChatFileSave.new = function(chat)
  local self = setmetatable({}, { __index = ChatFileSave })
  self.chat = chat
  return self
end

function ChatFileSave:save()
  local settings, msgs = self.chat:debug()
  if not settings and not msgs then
    util.notify("No chat messages to save in file", vim.log.levels.INFO)
    return
  end

  local models
  local adapter = vim.deepcopy(self.chat.adapter)
  self.adapter = adapter

  local bufname = buf_utils.name_from_bufnr(self.chat.context.bufnr)

  -- Get the current settings from the chat buffer rather than making new ones
  local current_settings = settings or {}

  if type(adapter.schema.model.choices) == "function" then
    models = adapter.schema.model.choices(adapter)
  else
    models = adapter.schema.model.choices
  end

  local lines = {}

  table.insert(lines, '-- Adapter: "' .. adapter.formatted_name .. '"')
  table.insert(lines, "-- Buffer: " .. self.chat.bufnr)
  table.insert(lines, '-- Context: "' .. bufname .. '" (' .. self.chat.context.bufnr .. ")")

  -- Add settings
  if not config.display.chat.show_settings then
    table.insert(lines, "")
    local keys = {}

    -- Collect all settings keys including those with nil defaults
    for key, _ in pairs(settings) do
      table.insert(keys, key)
    end

    -- Add any schema keys that have an explicit nil default
    for key, schema_value in pairs(adapter.schema) do
      if schema_value.default == nil and not vim.tbl_contains(keys, key) then
        table.insert(keys, key)
      end
    end

    table.sort(keys, function(a, b)
      local a_order = adapter.schema[a] and adapter.schema[a].order or 999
      local b_order = adapter.schema[b] and adapter.schema[b].order or 999
      if a_order == b_order then
        return a < b -- alphabetical sort as fallback
      end
      return a_order < b_order
    end)

    table.insert(lines, "local settings = {")
    for _, key in ipairs(keys) do
      local val = settings[key]
      local is_nil = adapter.schema[key] and adapter.schema[key].default == nil

      if key == "model" then
        local other_models = " -- "

        vim.iter(models):each(function(model, model_name)
          if type(model) == "number" then
            model = model_name
          end
          if model ~= val then
            other_models = other_models .. '"' .. model .. '", '
          end
        end)

        if type(val) == "function" then
          val = val(self.adapter)
        end
        if vim.tbl_count(models) > 1 then
          table.insert(lines, "  " .. key .. ' = "' .. val .. '", ' .. other_models)
        else
          table.insert(lines, "  " .. key .. ' = "' .. val .. '",')
        end
      elseif is_nil and current_settings[key] == nil then
        table.insert(lines, "  " .. key .. " = nil,")
      elseif type(val) == "number" or type(val) == "boolean" then
        table.insert(lines, "  " .. key .. " = " .. tostring(val) .. ",")
      elseif type(val) == "string" then
        table.insert(lines, "  " .. key .. ' = "' .. val .. '",')
      elseif type(val) == "function" then
        local expanded_val = val(self.adapter)
        if type(expanded_val) == "number" or type(expanded_val) == "boolean" then
          table.insert(lines, "  " .. key .. " = " .. tostring(val(self.adapter)) .. ",")
        else
          table.insert(lines, "  " .. key .. ' = "' .. tostring(val(self.adapter)) .. '",')
        end
      else
        table.insert(lines, "  " .. key .. " = " .. vim.inspect(val))
      end
    end
    table.insert(lines, "}")
  end

  -- Add messages
  if vim.tbl_count(self.chat.messages) > 0 then
    table.insert(lines, "")
    table.insert(lines, "local messages = ")

    local messages = vim.inspect(self.chat.messages)
    for line in messages:gmatch("[^\r\n]+") do
      table.insert(lines, line)
    end
  end

  local file = io.open("chat" .. os.date("%Y%m%d%H%M") .. ".save", "w")
  if file then
    local lines_string = table.concat(lines, "\n")
    file:write(lines_string)
    file:close()
  else
    util.notify("Could not open file for writing.", vim.log.levels.ERROR)
  end
end

return ChatFileSave
