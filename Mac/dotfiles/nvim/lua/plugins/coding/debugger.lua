-- Using lazy.nvim or packer
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mfussenegger/nvim-dap-python',
    'rcarriga/nvim-dap-ui',  -- Nice UI
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',  -- Shows variable values inline
  },
  config = function()
    -- Install debugpy first:
    -- pip install debugpy
    
    require('dap-python').setup('python')  -- or path to python with debugpy
    
    -- Key mappings
    local dap = require('dap')
    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F10>', dap.step_over)
    vim.keymap.set('n', '<F11>', dap.step_into)
    vim.keymap.set('n', '<F12>', dap.step_out)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    
    -- Auto-open UI
    local dapui = require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
  end
}
