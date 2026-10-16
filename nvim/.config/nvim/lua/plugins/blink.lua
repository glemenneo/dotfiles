-- Completion menu: LSP, paths, snippets and words from open buffers.
-- On Neovim 0.11+ blink passes its LSP capabilities to every server by itself.
return {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship the prebuilt Rust fuzzy matcher
    opts = {
        -- default preset: Ctrl+Y accepts, Ctrl+N/Ctrl+P or arrows move, Ctrl+Space opens, Ctrl+E closes
        keymap = { preset = "default" },
        appearance = { nerd_font_variant = "mono" },
        completion = { documentation = { auto_show = true } },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
}
