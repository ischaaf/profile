local M = {}
--- Reads the contents of a file into a string.
---@param filename string The path to the file.
---@return string|nil #The file contents as a string, or nil if an error occurs.
function M.read_file_to_string(filename)
  local fd = vim.uv.fs_open(filename, "r", 438)
  if not fd then
    print("Error opening file: " .. filename)
    return nil
  end

  local stat = vim.uv.fs_fstat(fd)
  if not stat then
    print("Error getting file stats: " .. filename)
    return nil
  end

  local data = vim.uv.fs_read(fd, stat.size, 0)
  vim.uv.fs_close(fd)
  if not data then
    return
  end
  return M.strip(data)
end

return M
