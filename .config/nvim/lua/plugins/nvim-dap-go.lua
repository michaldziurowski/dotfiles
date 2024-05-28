local uv = vim.loop

-- reading env file was taken from https://github.com/ellisonleao/dotenv.nvim/blob/main/lua/dotenv.lua
local function read_file(path)
  local fd = assert(uv.fs_open(path, "r", 438))
  local stat = assert(uv.fs_fstat(fd))
  local data = assert(uv.fs_read(fd, stat.size, 0))
  assert(uv.fs_close(fd))
  return data
end

local function parse_data(data)
  local values = vim.split(data, "\n")
  local out = {}
  for _, pair in pairs(values) do
    pair = vim.trim(pair)
    if not vim.startswith(pair, "#") and pair ~= "" then
      local splitted = vim.split(pair, "=")
      if #splitted > 1 then
        local key = splitted[1]
        local v = {}
        for i = 2, #splitted, 1 do
          local k = vim.trim(splitted[i])
          if k ~= "" then
            table.insert(v, splitted[i])
          end
        end
        if #v > 0 then
          local value = table.concat(v, "=")
          value, _ = string.gsub(value, '"', "")
          out[key] = value
        end
      end
    end
  end
  return out
end

local function get_env_file(env_file_name)
  local files = vim.fs.find(env_file_name, { upward = true, type = "file" })
  if #files == 0 then
    return
  end
  return files[1]
end

local function load_env_vars(file)
  if file == nil then
    local envFileName = vim.fn.input({ prompt = "Env file name: ", default = "_env_test" })
    file = get_env_file(envFileName)
  end

  local ok, data = pcall(read_file, file)
  if not ok then
    return
  end

  return parse_data(data)
end

return {
  "leoluz/nvim-dap-go",
  config = true,
  opts = function(_, opts)
    opts.dap_configurations = {
      {
        type = "go",
        name = "Debug with env file",
        request = "launch",
        program = "${file}",
        buildFlags = "",
        env = load_env_vars,
      },
    }
  end,
}
