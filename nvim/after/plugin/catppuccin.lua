require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    integrations = {
        treesitter = true,
        telescope = {
            enabled = true,
            -- style = "nvchad"
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
    }
})
