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
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanionChat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Open CodeCompanionActions" },
      { "<leader>ai", "<cmd>'<,'>CodeCompanion<cr>", mode = { "v" }, desc = "Open CodeCompanion inline" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n" }, desc = "Open CodeCompanion inline" },
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
            ["symbols"] = {
              opts = {
                provider = "snacks",
              },
            },
          },
          keymaps = {
            chat_file_save = {
              modes = {
                n = "ms",
              },
              callback = function(chat)
                require("plugins.codecompanionext.chat-file-save").new(chat):save()
              end,
              description = "Save chat to file",
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
