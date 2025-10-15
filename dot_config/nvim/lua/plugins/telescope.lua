return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local path = require("plenary.path")

      -- Custom path display function that truncates from the left
      local function path_display_with_left_truncation(_, path_str)
        local cwd = vim.fn.getcwd()
        local rel_path = path:new(path_str):make_relative(cwd)

        -- Get available width (adjust as needed, telescope uses about 60% of window width)
        local max_width = math.floor(vim.o.columns * 0.4)

        if #rel_path > max_width then
          -- Truncate from the left, showing ... at the start
          return "..." .. string.sub(rel_path, -(max_width - 3))
        end

        return rel_path
      end

      -- Apply to all pickers by default
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        path_display = path_display_with_left_truncation,
      })

      -- Also specifically configure LSP pickers
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        lsp_references = {
          path_display = path_display_with_left_truncation,
          show_line = true,
        },
        lsp_definitions = {
          path_display = path_display_with_left_truncation,
          show_line = true,
        },
        lsp_implementations = {
          path_display = path_display_with_left_truncation,
          show_line = true,
        },
        lsp_type_definitions = {
          path_display = path_display_with_left_truncation,
          show_line = true,
        },
      })

      return opts
    end,
  },
}
