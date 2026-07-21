-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- global lsp mappings
-- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
-- map("n", "<C-n>", "<cmd>e .<CR>", { desc = "Toggle Explorer" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

-- map("n", "<leader>e", "<cmd> lua vim.diagnostic.goto_next()<CR>", { desc = "Goto next error" })
-- map("n", "<leader>E", "<cmd> lua vim.diagnostic.goto_prev()<CR>", { desc = "Goto previous error" })
-- map("n", "<leader>f<space>", "<cmd> NvimTreeFindFile<CR> <cmd> NvimTreeFocus<CR>", { desc = "Focus file in file tree" })

map("x", "<leader>p", '"_dP')

-- Neotree
map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "Neotree open" })
-- map tmux default escape sequence to leave terminal mode
-- useful when emulating tmux tabs with neovim tabs
map("t", "<C-]><Esc>", "<C-\\><C-n>")
-- Backup keybind in case terminal mode is used within tmux
map("t", "<C-]>`", "<C-\\><C-n>")

-- tmux tab switch emulation
-- Track the last tab on tab leave
vim.api.nvim_create_autocmd("TabLeave", {
  callback = function()
    vim.g.lasttab = vim.api.nvim_get_current_tabpage()
  end,
})

-- Go the the last open tab
vim.api.nvim_create_user_command("LastTab", function()
  if vim.g.lasttab ~= nil then
    vim.api.nvim_set_current_tabpage(vim.g.lasttab)
  end
end, {})

vim.api.nvim_create_user_command("WinWorkspace", function()
  vim.api.nvim_command("Tabby rename_tab Editor")
  vim.api.nvim_command("tabe term://powershell.exe")
  vim.api.nvim_command("Tabby rename_tab Agent")
  vim.api.nvim_command("tabe term://powershell.exe")
  vim.api.nvim_command("Tabby rename_tab Admin")
  vim.api.nvim_command("tabn 1")
end, {})

-- Keybinding for calling last tab
map({ "n", "t", "i" }, "<C-]><C-]>", "<cmd>LastTab<CR>", { desc = "Go to last tab" })
map({ "n", "t", "i" }, "<C-]>0", "<cmd>tabn 1<CR>", { desc = "Go to tab 0" })
map({ "n", "t", "i" }, "<C-]>1", "<cmd>tabn 2<CR>", { desc = "Go to tab 1" })
map({ "n", "t", "i" }, "<C-]>2", "<cmd>tabn 3<CR>", { desc = "Go to tab 2" })
map({ "n", "t", "i" }, "<C-]>3", "<cmd>tabn 4<CR>", { desc = "Go to tab 3" })
map({ "n", "t", "i" }, "<C-]>4", "<cmd>tabn 5<CR>", { desc = "Go to tab 4" })

function InsertOnTerminal()
  if vim.bo.buftype == "terminal" and vim.api.nvim_get_mode().mode ~= "t" then
    vim.api.nvim_input("i")
  end
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = InsertOnTerminal,
})

vim.api.nvim_create_user_command("Powershell", function()
  vim.api.nvim_command("tabe term://powershell.exe")
end, {})

vim.keymap.set("n", "<leader>fx", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { desc = "Close all floating windows" })

vim.api.nvim_create_user_command("JsonFormat", function()
  vim.api.nvim_command("%!python -m json.tool")
end, {})
