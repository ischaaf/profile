---@type ChadrcConfig 
local M = {}


local fileinfo = function()
  local config = require("core.utils").load_config().ui.statusline
  local sep_style = config.separator_style

  local default_sep_icons = {
    default = { left = "", right = "" },
    round = { left = "", right = "" },
    block = { left = "█", right = "█" },
    arrow = { left = "", right = "" },
  }

  local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

  local sep_l = separators["left"]
  local sep_r = separators["right"]
  local function stbufnr()
    return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  end

  local icon = " 󰈚 "
  local path = vim.api.nvim_buf_get_name(stbufnr())
  -- local name = (path == "" and "Empty ") or path:match "([^/\\]+)[/\\]*$"
  local name = (path == "" and "Empty ") or path

  if name ~= "Empty " then
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

    if devicons_present then
      local ft_icon = devicons.get_icon(name)
      icon = (ft_icon ~= nil and " " .. ft_icon) or icon
    end

    name = " " .. name .. " "
  end

  return "%#St_file_info#" .. icon .. name .. "%#St_file_sep#" .. sep_r
end

M.ui = {
  theme = "catppuccin",
  statusline = {
    theme = "default",
    separator_style = "default",
    overriden_modules = function(modules)
      modules[2] = fileinfo()
    end,
  },

  tabufline = {
    enabled = false,
    lazyload = false,
  },
}

M.mappings = require "custom.mappings"

M.plugins = "custom.plugins"

return M
