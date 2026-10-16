-- Teaches lua_ls about Neovim (the vim.* API, plugin modules) when editing Lua config files
return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            -- luv types once vim.uv appears in a file
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
