return {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
        { "<leader>gg", "<cmd>Git<cr>",          desc = "Open git visualiser" },
        { "<leader>gs", "<cmd>G status<cr>",     desc = "Git status" },
        { "<leader>gd", "<cmd>G diff<cr>",       desc = "Git diff" },
        { "<leader>gp", "<cmd>G push<cr>",       desc = "Git push" },
        { "<leader>gl", "<cmd>G pull<cr>",       desc = "Git pull" },
        { "<leader>gf", "<cmd>G fetch<cr>",      desc = "Git fetch" },
        { "<leader>gb", "<cmd>G blame<cr>",      desc = "Git blame" },
        { "<leader>gc", "<cmd>G commit<cr>",     desc = "Git commit" },
    },
}
