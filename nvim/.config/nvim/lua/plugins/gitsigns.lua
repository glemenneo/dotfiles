-- Git change marks in the sign column, plus hunk actions under <leader>g
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(buf)
            local gs = require("gitsigns")
            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
            end
            -- ]c / [c jump between hunks (in diff mode they keep their built-in meaning)
            map("n", "]c", function()
                if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
            end, "Next git hunk")
            map("n", "[c", function()
                if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
            end, "Previous git hunk")
            map("n", "<leader>ga", gs.stage_hunk, "Stage (add) hunk")
            map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
            map("n", "<leader>gh", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>gB", gs.blame_line, "Blame this line")
        end,
    },
}
