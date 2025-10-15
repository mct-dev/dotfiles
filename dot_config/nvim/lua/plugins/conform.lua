return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      },
      formatters = {
        eslint_d = {
          -- Use --fix flag to apply all auto-fixable rules
          args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
        },
      },
    },
  },
}
