local M = {}

function M.open_nvim_tree()
    -- open the tree
    require("nvim-tree.api").tree.open()
end

function M.auto_close()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
        if bufname:match("NvimTree_") ~= nil then
            table.insert(invalid_win, w)
        end
    end
    if #invalid_win == #wins - 1 then
        -- Should quit, so we close all invalid windows.
        for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
    end
end

function M.setup()
    require("nvim-tree").setup {
        view = {
            number = true,
            relativenumber = true,
						width = 40
        },
        filters = {
            custom = { ".git" },
        },
    }

--    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = M.open_nvim_tree })
    vim.api.nvim_create_autocmd({ "QuitPre" }, { callback = M.auto_close })
end

return M
