-- F4/F5: one setup call (a second call used to drop the first one's options)
require("nvim-autopairs").setup({
    enable_check_bracket_line = false,
    check_ts = true,
    ts_config = {
        lua = { "string" },                -- no pairs inside Lua strings
        javascript = { "template_string" },
        java = false,                      -- no treesitter check for Java
    },
})

-- add () after a function picked from the completion menu
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
