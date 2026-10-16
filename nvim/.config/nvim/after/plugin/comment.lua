-- Built-in commenting (Neovim 0.10+): gcc toggles a line, gc + motion or selection
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment on line" })
vim.keymap.set("x", "<leader>/", "gc", { remap = true, desc = "Toggle comment on selection" })
