return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    keys[#keys + 1] = { "<leader>d", vim.lsp.buf.definition }
    keys[#keys + 1] = { "<leader>D", vim.lsp.buf.declaration }
    keys[#keys + 1] = { "<leader>r", vim.lsp.buf.references }
    keys[#keys + 1] = { "<leader>R", vim.lsp.buf.rename }
    keys[#keys + 1] = { "<leader>i", vim.lsp.buf.implementation }

    local new_opts = vim.tbl_deep_extend("force", opts, {
      servers = {
        gopls = {
          mason = false,
        },
        html = {},
        cssls = {},
        clangd = {},
        basedpyright = {},
        rust_analyzer = {},
        bashls = {},
        jsonls = {},
        gdscript = {},
      },
      inlay_hints = { enabled = false },
      document_highlight = {
        enabled = false,
      },
    })

    new_opts["servers"]["pyright"] = nil
    return new_opts
  end,
}
