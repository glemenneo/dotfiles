vim.g.mapleader = " "

-- Space+fv to open up Netrw
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex, { desc = "Open Netrw" })

-- Alt+j/Down and Alt+k/Up to move line up or down 1 space
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move current line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move current line up" })

vim.keymap.set("i", "<A-j>", "<ESC>:m .+1<CR>==gi", { desc = "Move current line down" })
vim.keymap.set("i", "<A-k>", "<ESC>:m .-2<CR>==gi", { desc = "Move current line up" })

vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = "Move current line down" })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = "Move current line up" })

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move current line down" })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move current line up" })

vim.keymap.set("i", "<A-Down>", "<ESC>:m .+1<CR>==gi", { desc = "Move current line down" })
vim.keymap.set("i", "<A-Up>", "<ESC>:m .-2<CR>==gi", { desc = "Move current line up" })

vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = "Move current line down" })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = "Move current line up" })

-- Space+s to auto format file
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { desc = "Auto format buffer" })

-- Space+s to replace all instances of word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace all occurences of the current word" })

-- Tab/Shift+tab to indent/dedent
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent line" })
vim.keymap.set("n", "<Tab>", "v><C-\\><C-N>", { desc = "Indent line" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Dedent line" })
vim.keymap.set("n", "<S-Tab>", "v<<C-\\><C-N>", { desc = "Dedent line" })
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Dedent line" })
