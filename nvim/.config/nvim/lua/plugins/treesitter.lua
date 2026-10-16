-- nvim-treesitter (main branch) installs parsers; Neovim itself does the highlighting
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- the main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        ts.install({ "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" })

        -- Highlight every filetype that has a parser; a missing one installs on first open (like the old auto_install)
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                if pcall(vim.treesitter.start, args.buf) then return end
                local lang = vim.treesitter.language.get_lang(args.match)
                if lang and vim.list_contains(ts.get_available(), lang) then
                    ts.install(lang):await(function(err)
                        if not err then
                            vim.schedule(function() pcall(vim.treesitter.start, args.buf) end)
                        end
                    end)
                end
            end,
        })
    end,
}
