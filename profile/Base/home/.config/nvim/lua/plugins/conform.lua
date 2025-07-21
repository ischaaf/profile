Later(function()
  Add({
    source = "stevearc/conform.nvim",
  })
  require("conform").setup({
    formatters_by_ft = {
      ["_"] = { "trim_whitespace" },
      lua = { "stylua" },
      go = { "goimports" },
      python = { "isort", "black" },
      gdscript = { "gdformat" },
      rust = { "rustfmt", lsp_format = "fallback" },
      sh = { "shfmt" },
      bash = { "shfmt" },
    },
  })

  vim.g.disable_autoformat = false

  local format_fn = function()
    local function myCallback(err)
      if err then
        vim.notify("Error during formatting: ", string(err))
      else
        vim.notify("Formatting completed successfully.")
      end
    end
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    }, myCallback())
  end

  vim.api.nvim_create_user_command("Format", format_fn, {
    desc = "format",
  })

  -- Format on save for specific file types
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.py", "*.go", "*.rs", "*.gd", "*.lua" },
    callback = function()
      if not vim.g.disable_autoformat then
        format_fn()
      end
    end,
  })

  vim.keymap.set("n", "<Leader>lf", "<Cmd>silent Format<CR>", { desc = "Format the current file", silent = true })
end)
