return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
    },
    lazy = false,
    keys = {
      { "<leader>cct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanionChat" },
      { "<leader>cca", "<cmd>CodeCompanionActions<cr>", desc = "Open CodeCompanionActions" },
      { "<leader>cci", "<cmd>'<,'>CodeCompanion<cr>", mode = { "v" }, desc = "Open CodeCompanion inline" },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
        },
      },
      display = {
        diff = {
          provider = "mini_diff", -- default|mini_diff
        },
      },
      prompt_library = {
        ["My commit"] = {
          strategy = "chat",
          description = "Generate a commit message",
          opts = {
            index = 10,
            is_default = true,
            is_slash_cmd = true,
            short_name = "mcommit",
            auto_submit = true,
          },
          prompts = {
            {
              role = "user",
              condition = function(context)
                local result = vim.fn.system("git diff --no-ext-diff --staged")
                if result == "" then
                  return "heyho"
                else
                  return true
                end
              end,
              content = function()
                return string.format(
                  [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
%s
```
]],
                  vim.fn.system("git diff --no-ext-diff --staged")
                )
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
    },
    init = function()
      require("plugins.codecompanion.fidget-spinner"):init()
    end,
  },
}
