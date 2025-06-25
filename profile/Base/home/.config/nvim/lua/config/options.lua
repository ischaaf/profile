-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local g = vim.g
local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

g.mapleader = ";"
opt.clipboard = ""
opt.guicursor = ""
-- opt.backup = false
-- opt.swapfile = false

opt.scrolloff = 10
opt.relativenumber = true
opt.wrap = false

-- opt.shiftwidth = 4
-- opt.softtabstop = 4
-- opt.tabstop = 4
-- opt.expandtab = true
-- opt.mouse = ""

opt.list = true
opt.listchars = "tab:›·,trail:·"

-- vim.o.cursorlineopt = "number"
-- vim.o.number = true
-- vim.o.numberwidth = 2
-- vim.o.ruler = false
vim.o.showtabline = 0
opt.cursorline = false

opt.shortmess:append("sI")
g.lazyvim_picker = "telescope"
g.snacks_animate = false
g.ai_cmp = false

-- vim.o.signcolumn = "yes"
-- vim.o.splitbelow = true
-- vim.o.splitright = true
-- vim.o.timeoutlen = 400
-- vim.o.undofile = true
-- vim.cmd [[colorscheme dracula]]

-- interval for writing swap file to disk, also used by gitsigns
-- vim.o.updatetime = 250

-- local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
-- vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

autocmd("FileType", {
  pattern = "*.go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.sotftabstop = 4
    vim.opt_local.tabstop = 4
  end,
})

local function set_tab(opts)
  local tabval = tonumber(opts.args)
  vim.opt.shiftwidth = tabval
  vim.opt.tabstop = tabval
end

vim.api.nvim_create_user_command("SetTab", set_tab, { nargs = "?" })

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"
  vim.g.neovide_cursor_animation_length = 0
end
