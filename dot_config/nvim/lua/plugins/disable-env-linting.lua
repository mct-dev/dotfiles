return {
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Create autocmd to override filetype for .env files
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.env", ".env", ".env.*", "*.env.*" },
        callback = function()
          vim.bo.filetype = "config"
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash" },
        },
      },
      setup = {
        bashls = function(_, opts)
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")

          -- Don't attach bashls to .env files
          opts.root_dir = function(fname)
            local filename = vim.fn.fnamemodify(fname, ":t")
            if filename:match("%.env") or filename:match("^%.env") then
              return nil
            end
            return util.find_git_ancestor(fname) or util.path.dirname(fname)
          end

          lspconfig.bashls.setup(opts)
          return true
        end,
      },
    },
  },
}
