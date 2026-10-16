return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons", version = false },
    config = function()
        local wk = require("which-key")
        wk.setup()
        wk.add({
            { "<leader>f", group = "File" },
            { "<leader>z", group = "LSP" },
            { "<leader>g", group = "Git" },
            {
                mode = { "n", "v" },
                { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
                { "<leader>w", "<cmd>w<cr>", desc = "Write" },
            },
        })
    end,
}
