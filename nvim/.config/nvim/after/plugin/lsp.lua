-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- nvim-cmp's completion capabilities for every server (Neovim 0.11+ vim.lsp.config)
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        vim.keymap.set('n', '<leader>zk', '<cmd>lua vim.lsp.buf.hover()<cr>',
            { buffer = event.buf, desc = "Display hover information" })
        vim.keymap.set('n', '<leader>zd', '<cmd>lua vim.lsp.buf.definition()<cr>',
            { buffer = event.buf, desc = "Jump to the definition" })
        vim.keymap.set('n', '<leader>zD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
            { buffer = event.buf, desc = "Jump to the declaration" })
        vim.keymap.set('n', '<leader>zi', '<cmd>lua vim.lsp.buf.implementation()<cr>',
            { buffer = event.buf, desc = "List all implementations" })
        vim.keymap.set('n', '<leader>zo', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
            { buffer = event.buf, desc = "Jump to the type definition" })
        vim.keymap.set('n', '<leader>zr', '<cmd>lua vim.lsp.buf.references()<cr>',
            { buffer = event.buf, desc = "List all references" })
        vim.keymap.set('n', '<leader>zs', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
            { buffer = event.buf, desc = "Display signature information" })
        vim.keymap.set('n', '<leader>s', '<cmd>lua vim.lsp.buf.rename()<cr>',
            { buffer = event.buf, desc = "Rename all references" })
        vim.keymap.set({ 'n', 'x' }, '<leader>zf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
            { buffer = event.buf, desc = "Format all code" })
        vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>',
            { buffer = event.buf, desc = "Select a code action" })
    end,
})

-- mason installs the servers; mason-lspconfig v2 calls vim.lsp.enable() for each installed one
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'rust_analyzer' },
})
