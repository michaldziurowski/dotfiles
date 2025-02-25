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
          slash_commands = {
            ["file"] = {
              opts = {
                provider = "snacks",
              },
            },
            ["buffer"] = {
              opts = {
                provider = "snacks",
              },
            },
          },
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
    },
    init = function()
      require("plugins.codecompanionext.fidget-spinner"):init()
    end,
  },
}
