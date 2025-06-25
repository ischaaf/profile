return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
      scroll = {
        enabled = false,
      },
      picker = {
        hidden = true,
        ignored = true,
        sources = {
          files = {
            hidden = true,
          },
        },
      },
      dashboard = {
        enabled = false,
      },
    })
  end,
}
