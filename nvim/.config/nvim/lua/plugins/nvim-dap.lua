-- Debugger (Go via nvim-dap-go); loads on the first debug key
local function dap(fn) return function() require("dap")[fn]() end end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
        "leoluz/nvim-dap-go",
    },
    keys = {
        { "<leader>bb", dap("toggle_breakpoint"), desc = "Toggle Breakpoint" },
        { "<leader>bc", dap("continue"),          desc = "Continue" },
        { "<leader>dn", dap("step_over"),         desc = "Step Over" },
        { "<leader>di", dap("step_into"),         desc = "Step Into" },
        { "<leader>du", dap("step_out"),          desc = "Step Out" },
        { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
        { "<leader>dq", function() require("dap").terminate() require("dapui").close() end, desc = "Terminate and Close UI" },
        { "<leader>df", function() require("dapui").open() end,  desc = "Open DAP UI" },
        { "<leader>dh", function() require("dapui").close() end, desc = "Close DAP UI" },
        { "<leader>dl", dap("run_last"),          desc = "Run Last" },
        { "<leader>da", dap("continue"),          desc = "Attach to Debug Target" },
        { "<leader>dd", dap("run_to_cursor"),     desc = "Run to Cursor" },
    },
    config = function()
        require("dap-go").setup()
        require("dapui").setup()
    end,
}
