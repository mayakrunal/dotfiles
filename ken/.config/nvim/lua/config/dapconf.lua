local M = {}

function M.setup()
    local dap, dapui = require("dap"), require("dapui")

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F10>', dap.step_over)
    vim.keymap.set('n', '<F11>', dap.step_into)
    vim.keymap.set('n', '<F12>', dap.step_out)
    vim.keymap.set('n', '<F6>', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dr', dap.repl.open)
    vim.keymap.set('n', '<leader>dl', dap.run_last)

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = '', linehl = 'DapLogPoint', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition',
        { text = '', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = 'R', texthl = '', linehl = '', numhl = '' })

    require("nvim-dap-virtual-text").setup()


    --python debugging
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
end

return M
