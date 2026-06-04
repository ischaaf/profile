Later(function()
  Add({
    source = "obsidian-nvim/obsidian.nvim",
  })

  require("obsidian").setup {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
      {
        name = "notes",
        path = "~/notes",
      },
    },
  }
end)
