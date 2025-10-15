return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Customize the filename component to show full path relative to project root
      -- and truncate from the left instead of middle
      opts.sections.lualine_c = {
        {
          "filename",
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          shorting_target = 0, -- disable default truncation
          fmt = function(str)
            -- This will cause truncation from the left by placing %< at the start
            return "%<" .. str
          end,
        },
      }
      return opts
    end,
  },
}
