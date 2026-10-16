-- Language servers: mason installs them, mason-lspconfig v2 enables each installed one
-- (vim.lsp.enable), nvim-lspconfig supplies the server definitions. blink.cmp adds the
-- completion capabilities itself.
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    config = function()
        -- keys that only make sense with a server attached
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function(event)
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
                end
                map("n", "<leader>zk", vim.lsp.buf.hover, "Display hover information")
                map("n", "<leader>zd", vim.lsp.buf.definition, "Jump to the definition")
                map("n", "<leader>zD", vim.lsp.buf.declaration, "Jump to the declaration")
                map("n", "<leader>zi", vim.lsp.buf.implementation, "List all implementations")
                map("n", "<leader>zo", vim.lsp.buf.type_definition, "Jump to the type definition")
                map("n", "<leader>zr", vim.lsp.buf.references, "List all references")
                map("n", "<leader>zs", vim.lsp.buf.signature_help, "Display signature information")
                map("n", "<leader>s", vim.lsp.buf.rename, "Rename all references")
                map({ "n", "x" }, "<leader>zf", function() vim.lsp.buf.format({ async = true }) end, "Format all code")
                map("n", "<leader>a", vim.lsp.buf.code_action, "Select a code action")
            end,
        })

        -- Go: on save, gopls adds/removes imports, then formats (what vim-go did with its own gopls)
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function(args)
                local client = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })[1]
                if not client then return end
                local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
                params.context = { only = { "source.organizeImports" }, diagnostics = {} }
                local res = client:request_sync("textDocument/codeAction", params, 3000, args.buf)
                for _, action in ipairs(res and res.result or {}) do
                    if action.edit then vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding) end
                end
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 3000 })
            end,
        })

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "gopls" },
        })

        -- delve (the Go debugger nvim-dap-go uses) isn't a language server, so mason-lspconfig
        -- doesn't install it; mason puts it on Neovim's PATH
        local registry = require("mason-registry")
        registry.refresh(function()
            if not registry.is_installed("delve") then registry.get_package("delve"):install() end
        end)
    end,
}
