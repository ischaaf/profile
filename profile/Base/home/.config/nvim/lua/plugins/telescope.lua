Later(function()
  Add({
    source = "nvim-telescope/telescope.nvim",
    depends = { "nvim-lua/plenary.nvim" },
  })

  require("telescope").setup({})
end)
