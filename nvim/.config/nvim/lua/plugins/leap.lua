return {
    url = "https://codeberg.org/andyg/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    keys = {
        { "s", "<Plug>(leap)",             mode = { "n", "x", "o" }, desc = "Leap in current window" },
        { "S", "<Plug>(leap-from-window)", desc = "Leap from other window" },
    },
}
