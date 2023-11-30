local present, lspconfig = pcall(require, "lspconfig")
local utils = require "core.utils"

if not present then
  return
end

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local safe_on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
      {"🭽", "FloatBorder"},
      {"▔", "FloatBorder"},
      {"🭾", "FloatBorder"},
      {"▕", "FloatBorder"},
      {"🭿", "FloatBorder"},
      {"▁", "FloatBorder"},
      {"🭼", "FloatBorder"},
      {"▏", "FloatBorder"},
}

lspconfig.gopls.setup {
  on_attach = safe_on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      completeUnimported = true,
    },
  },
}
lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.pyright.setup {
  on_attach = safe_on_attach,
  capabilities = capabilities,
}
lspconfig.omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

vim.o.updatetime = 250
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus=false,
      border="single"
    })
  end
})



local pid = vim.fn.getpid()
-- "/mnt/c/Users/isaac/AppData/Local/omnisharp-vim/omnisharp-rosly/OmniSharp.exe", "--languageserver", "--hostPID", tostring(pid)
-- "/root/.local/share/nvim/mason/packages/omnisharp-mono/run", "--languageserver", "--hostPID", tostring(pid)
-- "/root/.local/share/nvim/mason/packages/omnisharp/omnisharp", "--languageserver", "--hostPID", tostring(pid)

lspconfig.omnisharp.setup {
  on_attach = safe_on_attach,
  capabilities = capabilities,
  cmd = {
    "/mnt/c/Users/isaac/Downloads/omnisharp-win-x64/OmniSharp.exe", "--languageserver", "--hostPID", tostring(pid)
  },
}


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- disable inline text, replace it with a hover window
    vim.diagnostic.config({
      virtual_text = false
    })

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {'*.go', '*.py'},
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})
