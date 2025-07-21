---@diagnostic disable: missing-fields
Later(function()
  Add({
    source = "folke/trouble.nvim",
  })

  require("trouble").setup({
    modes = {
      lsp = {
        win = {
          type = "split",
          relative = "win",
          position = "bottom",
          size = 0.25,
        },
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.5,
        },
        sections = {
          "lsp_definitions",
          "lsp_references",
          "lsp_implementations",
          -- "lsp_type_definitions",
          -- "lsp_declarations",
          "lsp_incoming_calls",
          -- "lsp_outgoing_calls",
        },
      },
      sources = {
        win = {
          type = "split",
          relative = "win",
          position = "bottom",
          size = 0.25,
        },
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },
    debug = false,
    auto_close = false,
    auto_jump = true,
    auto_open = false,
    auto_preview = true,
    auto_refresh = false,
    focus = false,
    follow = false,
  })

  local trouble_focus_reference = function()
    vim.cmd("Trouble lsp refresh")
    vim.cmd("Trouble lsp focus")
  end

  vim.api.nvim_create_user_command("TroubleRefresh", trouble_focus_reference, {})

  vim.keymap.set("n", "<leader>r", "<cmd>TroubleRefresh<cr>", { desc = "References (Trouble)" })
  vim.keymap.set("n", "<leader>cS", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
  vim.keymap.set(
    "n",
    "<leader>cs",
    "<cmd>Trouble lsp toggle<cr>",
    { desc = "LSP references/definitions/... (Trouble)" }
  )
end)
