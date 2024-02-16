local M = {}

M.ui = {
  statusline = { 
    theme = "minimal",
    separator_style = "default",
    overriden_modules = function(modules)
      table.insert(
        modules,
        2,
        (function()
          return " between mode and filename ! "
        end)()
      )
    end,
  },

  tabufline = {
    enabled = false,
    lazyload = false,
  },
}

M.gitsigns = {
  current_line_blame = true,
}

M.treesitter = {
  ensure_installed = {
    "bash",
    "go",
    "gomod",
    "gowork",
    "json",
    "lua",
    "make",
    "yaml",
    "python",
  },

  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]]"] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
      },
    },
  },
}

M.mason = {
  ensure_installed = {
    "lua-language-server",
    "stylua",
    "gopls",
    "goimports",
    "shfmt",
    "shellcheck",
    "pyright",
    "mypy",
    "ruff",
    "rust-analyzer",
  },
}

return M
