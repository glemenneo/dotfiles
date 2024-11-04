-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

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
        vim.keymap.set({ 'n', 'x' }, '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
            { buffer = event.buf, desc = "Format all code" })
        vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>',
            { buffer = event.buf, desc = "Select a code action" })
    end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'lua_ls', 'rust_analyzer' },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})
