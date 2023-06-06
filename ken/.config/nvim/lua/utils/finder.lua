local M = {}

function M.find_files()
    local fzf = require "fzf-lua"
    if vim.fn.system "git rev-parse --is-inside-work-tree" == true then
        fzf.git_files()
    else
        fzf.files({
            fd_opts = "--type file --hidden --follow --color='always' " ..
                "--exclude='.git' " ..
                "--exclude='node_modules' " ..
                "--exclude='.gradle' " ..
                "--exclude='.settings' " ..
                "--exclude='bin'"
        })
    end
end

return M
