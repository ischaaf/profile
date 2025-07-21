-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.options")
require("config.mini")
require("config.lsp")
require("config.keymaps")
require("plugins")

vim.cmd("colorscheme catppuccin")
