-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local g = vim.g
local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.signcolumn = "yes"

g.mapleader = ";"
opt.clipboard = ""
opt.guicursor = ""
-- opt.backup = false
-- opt.swapfile = false

opt.scrolloff = 10
opt.number = true
opt.relativenumber = true
opt.wrap = false

-- opt.shiftwidth = 4
-- opt.softtabstop = 4
-- opt.tabstop = 4
-- opt.expandtab = true
-- opt.mouse = ""

opt.list = true
opt.listchars = "tab:› ,trail:·"

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

function DumpTable(o, maxdepth)
  print(DumpTableDepth(o, maxdepth, 0))
end

function DumpTableDepth(o, maxdepth, curdepth)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      local line_entry
      if curdepth >= maxdepth then
        line_entry = string.format("[%s] = <maxdepth>", k)
      else
        line_entry = string.format("[%s] = %s,", k, DumpTableDepth(v, maxdepth, curdepth + 1))
      end
      s = s .. string.format("\n%s%s", string.rep(" ", curdepth + 1), line_entry)
    end
    return s .. string.format("\n%s}", string.rep(" ", curdepth))
  else
    return tostring(o)
  end
end

function PrintKeys(o)
  for k, _ in pairs(o) do
    print(k)
  end
end

function PrintPlugins()
  DumpTable(require("lazy").plugins(), 10)
end

vim.api.nvim_create_user_command("PrintPlugins", PrintPlugins, {})
