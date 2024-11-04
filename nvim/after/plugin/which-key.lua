local wk = require("which-key")
wk.add({
    { "<leader>f",  group = "File" }, -- group
    { "<leader>z", group = "LSP"},
    { "<leader>g", group = "Git"},
    {
        -- Nested mappings are allowed and can be added in any order
        -- Most attributes can be inherited or overridden on any level
        -- There's no limit to the depth of nesting
        mode = { "n", "v" },                          -- NORMAL and VISUAL mode
        { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
        { "<leader>w", "<cmd>w<cr>", desc = "Write" },
    }
})
