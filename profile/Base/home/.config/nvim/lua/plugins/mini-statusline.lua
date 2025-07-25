Later(function()
  Add("echasnovski/mini.statusline")

  local blocked_filetypes = {
    ["man"] = true,
    ["dashboard"] = true,
  }

  local MiniStatusline = require("mini.statusline")
  require("mini.statusline").setup({
    content = {
      active = function()
        if blocked_filetypes[vim.bo.filetype] then
          vim.cmd("highlight StatusLine guibg=NONE guifg=NONE")
          return ""
        end
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 75 })
        local git = MiniStatusline.section_git({ trunc_width = 75 })
        local filename = MiniStatusline.section_filename({ trunc_width = 120 })
        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
        local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location = MiniStatusline.section_location({ trunc_width = 75 })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
        return MiniStatusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- End left alignment
          { hl = "MiniStatuslineDevinfo", strings = { lsp, git, diagnostics } },
          "%<", -- Mark general truncate point
          { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        })
      end,
    },
    use_icons = true,
  })
end)
