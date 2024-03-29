local M = {}

M.disabled = {
  n = {
    ["<leader>n"] = "",
    ["<leader>rh"] = "",
    ["<leader>ra"] = "",
    ["<leader>rn"] = ""
  }
}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    ["<leader>e"] = { "<cmd> lua vim.diagnostic.goto_next()<CR>", "Goto next error" },
    ["<leader>E"] = { "<cmd> lua vim.diagnostic.goto_prev()<CR>", "Goto previous error" },
    ["<leader>f<space>"] = { "<cmd> NvimTreeFindFile<CR> <cmd> NvimTreeFocus<CR>", "Focus file in file tree" },
  }
}

M.omnisharp_vim = {
  plugin = true,
  n = {
    ["<leader>d"] = {"<cmd> OmniSharpGotoDefinition<CR>", "Goto Definition"}
  }
}

return M
