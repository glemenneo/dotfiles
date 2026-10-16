-- snacks.nvim: only the file tree sidebar for now; every other snacks module stays off until enabled
return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        explorer = { replace_netrw = false }, -- `nvim <dir>` keeps opening yazi
        picker = { sources = { explorer = { hidden = true } } }, -- show dotfiles, like VS Code
    },
    keys = {
        { "<leader>E", function() Snacks.explorer() end, desc = "File tree sidebar" },
    },
}
