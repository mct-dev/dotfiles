return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "ravitemer/codecompanion-history.nvim",
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
      -- Initialize the spinner
      require("utils.codecompanion-spinner").setup()
    end,
    keys = {
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle AI Chat",
        mode = "n",
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "claude_code",
        },
        inline = {
          adapter = "claude_code",
        },
      },
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                ANTHROPIC_API_KEY = "ANTHROPIC_API_KEY",
              },
            })
          end,
        },
      },
    },
  },
}


