-- yazi.nvim: yazi in a floating window, replacing nvim-tree and netrw
return {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { { "nvim-lua/plenary.nvim", lazy = true } },
    keys = {
        { "<leader>e",  mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Yazi at the current file" },
        { "<leader>fv", "<cmd>Yazi cwd<cr>",    desc = "Yazi in the working directory" },
        { "<c-up>",     "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
    },
    opts = {
        open_for_directories = true, -- `nvim .` and :e <dir> open yazi instead of netrw
        keymaps = { show_help = "<f1>" },
    },
    init = function()
        vim.g.loaded_netrwPlugin = 1 -- netrw never loads
    end,
}
