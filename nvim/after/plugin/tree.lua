require("nvim-tree").setup({
    disable_netrw = false,
    hijack_netrw = false,
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

local api = require "nvim-tree.api"

vim.keymap.set("n", "<C-b>", api.tree.toggle, {desc = "Toggle NvimTree side bar"})
-- vim.keymap.set("n", "<leader>fv", api.tree.open)


