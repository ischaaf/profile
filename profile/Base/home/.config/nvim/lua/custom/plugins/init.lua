local override = require "custom.plugins.configs.override"

return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      ---@diagnostic disable-next-line: different-requires
      require "custom.plugins.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.configs.null-ls"
    end,
  },
  { "williamboman/mason.nvim", override_options = override.mason },

  { "christoomey/vim-tmux-navigator", lazy = false },

  -- UI
  { "goolord/alpha-nvim", disable = false },
  { "folke/which-key.nvim", disable = false },
  { "NvChad/ui", override_options = override.ui },

  -- Git
  { "lewis6991/gitsigns.nvim", override_options = override.gitsigns },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", override_options = override.treesitter },
  { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = function()
      require "custom.plugins.configs.treesitter-context"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return require "custom.plugins.configs.nvimtree"
    end,
  },

  -- Editor
  {
    "tpope/vim-surround",
    opt = true,
    event = "BufReadPost",
  },
  {
    "hrsh7th/vim-eft",
    opt = true,
    event = "BufReadPost",
  },
}
