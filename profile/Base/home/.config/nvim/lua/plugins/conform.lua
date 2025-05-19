return {
  'stevearc/conform.nvim',
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        sh = { "shfmt" },
      }
    })
  end,
}
