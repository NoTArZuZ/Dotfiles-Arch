return {
  -- Plugins
  { "vyfor/cord.nvim", enabled = false },
  {
    "nativerv/cyrillic.nvim",
    event = { "VeryLazy" },
    config = function()
      require("cyrillic").setup({
        no_cyrillic_abbrev = false, -- default
      })
    end,
  },

  -- Themes
  { "vague2k/vague.nvim" },

  -- Settings
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vague",
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      indent = { enabled = false },
      picker = {
        hidden = true,
        sources = { files = { hidden = true } },
      },
    },
  },
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "│", right = "│" }
    end,
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return {
  --       options = {
  --         theme = "auto",
  --         component_separators = { left = "", right = "" },
  --         section_separators = { left = "", right = "" },
  --         disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     inlay_hints = { enabled = false },
  --   },
  -- },
}
