return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      lsp = {
        win = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
      sources = {
        win = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },
  },
  keys = {
    { "<leader>cS", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
    { "<leader>cs", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
  },
}
