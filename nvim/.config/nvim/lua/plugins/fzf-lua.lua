-- Fuzzy finder on fzf, fd and ripgrep (replaces Telescope)
return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
        { "<leader>ff", function() require("fzf-lua").files() end,     desc = "Find files" },
        { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
        { "<leader>fb", function() require("fzf-lua").buffers() end,   desc = "Buffers" },
        { "<leader>fh", function() require("fzf-lua").git_files() end, desc = "Git files" },
    },
    opts = {},
}
