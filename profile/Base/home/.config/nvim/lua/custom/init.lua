local g = vim.g
local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

g.mapleader = ";"
opt.clipboard = ""
opt.guicursor = ""

opt.backup = false
opt.swapfile = false

opt.scrolloff = 10
opt.relativenumber = true
opt.wrap = false

opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.mouse = ""

opt.list = true
opt.listchars = "tab:›·,trail:·"

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

autocmd("FileType", {
    pattern = "*.go",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.shiftwidth = 4
        vim.opt_local.sotftabstop = 4
        vim.opt_local.tabstop = 4
    end,
})

autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.format { async = false }
    end,
})

local function set_tab(opts)
    local tabval = tonumber(opts.args)
    vim.opt.shiftwidth = tabval
    vim.opt.tabstop = tabval
end

vim.api.nvim_create_user_command("SetTab", set_tab, { nargs = "?" })

local m = {
    commands = { "gopls.tidy" }
}
