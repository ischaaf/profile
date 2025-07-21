---@class Module
local M = {}

---@type string
local ORIGINAL_PATH = vim.fn.getenv("PATH") or ""

--- The current virtual environment path, or nil if none is set.
---@type string|nil
M.cur_env = nil

local utils = require("extras.utils")

--- Find the virtual environment directory.
---@return string|nil # The path to the virtual environment, or nil if not found.
local function find_env()
  ---@type string|nil
  local root = vim.fs.root(0, { ".git", "pyproject.toml" })
  if not root then
    return nil
  end
  ---@type string
  local pyenvpath = root .. ".python-version"
  local pythonversion = utils.read_file_to_string(pyenvpath)
  if pythonversion and #pythonversion > 0 then
    local version_path = "~/.profile.d/staging/tools/pyenv/versions/" .. pythonversion
    return vim.fn.expand(version_path)
  end
  return nil
end

--- Set the virtual environment for the current project.
function M.setup()
  ---@type string|nil
  local virtual_env = find_env()

  if not virtual_env then
    return
  end

  if M.cur_env ~= virtual_env then
    M.cur_env = virtual_env
  else
    return
  end

  vim.fn.setenv("PATH", virtual_env .. "/bin:" .. ORIGINAL_PATH)
  vim.fn.setenv("VIRTUAL_ENV", virtual_env)
end

return M
-- vim: fdm=marker fdl=0
