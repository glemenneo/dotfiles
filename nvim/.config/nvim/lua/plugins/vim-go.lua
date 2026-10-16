-- vim-go for :GoRun, :GoTest and :GoBuild. Code intelligence (completion,
-- definitions, renames) comes from Neovim's LSP client with gopls, so vim-go doesn't start its own.
return {
    "fatih/vim-go",
    ft = "go",
    init = function()
        vim.g.go_gopls_enabled = 0
        vim.g.go_code_completion_enabled = 0 -- blink.cmp completes Go
        vim.g.go_def_mapping_enabled = 0     -- gd/Ctrl-] stay Neovim's; LSP jumps are on <leader>z
        vim.g.go_fmt_autosave = 0            -- gopls organizes imports and formats on save (lsp.lua)
        vim.g.go_imports_autosave = 0
    end,
}
