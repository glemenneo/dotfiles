require('dap-go').setup()
require("dapui").setup()

vim.keymap.set('n', '<leader>bb', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>bc', function() dap.continue() end, { desc = 'Continue' })
vim.keymap.set('n', '<leader>dn', function() dap.step_over() end, { desc = 'Step Over' })
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = 'Step Into' })
vim.keymap.set('n', '<leader>du', function() dap.step_out() end, { desc = 'Step Out' })
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { desc = 'Open REPL' })
vim.keymap.set('n', '<leader>dq', function() dap.terminate() dapui.close() end, { desc = 'Terminate and Close UI' })

-- UI interaction
vim.keymap.set('n', '<leader>df', function() dapui.open() end, { desc = 'Open DAP UI' })
vim.keymap.set('n', '<leader>dh', function() dapui.close() end, { desc = 'Close DAP UI' })
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Run Last' })

-- Advanced DAP features
vim.keymap.set('n', '<leader>da', function() dap.continue() end, { desc = 'Attach to Debug Target' })
vim.keymap.set('n', '<leader>dd', function() dap.run_to_cursor() end, { desc = 'Run to Cursor' }) 
