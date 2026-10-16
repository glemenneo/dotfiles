-- Built-in undotree (Neovim 0.12+); :Undotree toggles the window
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", vim.cmd.Undotree, { desc = "Toggle Undotree" })
