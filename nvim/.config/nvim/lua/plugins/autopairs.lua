return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
            lua = { "string", "string_content" }, -- no pairs inside Lua strings (newer parsers name the inside string_content)
            javascript = { "template_string" },
            java = false,                         -- no treesitter check for Java
        },
    },
}
