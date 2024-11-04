vim.keymap.set("n", "<leader>gg", vim.cmd.Git, {desc = "Open git visualiser"})
vim.keymap.set("n", "<leader>gs", ":G status<CR>", {desc = "Git status"})
vim.keymap.set("n", "<leader>gd", ":G diff<CR>", {desc = "Git diff"})
vim.keymap.set("n", "<leader>gp", ":G push<CR>", {desc = "Git push"})
vim.keymap.set("n", "<leader>gl", ":G pull<CR>", {desc = "Git pull"})
vim.keymap.set("n", "<leader>gf", ":G fetch<CR>", {desc = "Git fetch"})
vim.keymap.set("n", "<leader>gb", ":G blame<CR>", {desc = "Git blame"})


