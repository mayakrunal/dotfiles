local M = {}

function M.setup()
  -- vim.cmd [[highlight IndentBlanklineContextStart guisp=#56B6C2 gui=underline]]
  -- vim.cmd [[highlight IndentBlanklineContext guisp=#56B6C2 gui=underline]]

  require("indent_blankline").setup {

    char = "┊",
    --space_char_blankline = " ",
    show_trailing_blankline_indent = false,
    filetype_exclude = { "help", "packer" },
    buftype_exclude = { "terminal", "nofile" },
    show_current_context = true,
    show_current_context_start = true,

  }
end

return M
