return {
    "mrjones2014/smart-splits.nvim",
    opts = {
        default_amount = 10,
    },
    event = { "VeryLazy" },
    keys = {
        {
            "<A-Left>",
            function() require("smart-splits").resize_left() end,
            desc = "Resize Left",
        },
        {
            "<A-Down>",
            function() require("smart-splits").resize_down() end,
            desc = "Resize Down",
        },
        {
            "<A-Up>",
            function() require("smart-splits").resize_up() end,
            desc = "Resize Up",
        },
        {
            "<A-Right>",
            function() require("smart-splits").resize_right() end,
            desc = "Resize Right",
        },
        -- moving between splits
        { "<C-Left>", function() require("smart-splits").move_cursor_left() end },
        { "<C-Down>", function() require("smart-splits").move_cursor_down() end },
        { "<C-Up>", function() require("smart-splits").move_cursor_up() end },
        { "<C-Right>", function() require("smart-splits").move_cursor_right() end },
        { "<C-\\>", function() require("smart-splits").move_cursor_previous() end },
        -- swapping buffers between windows
        {
            "<leader><leader>Right",
            function() require("smart-splits").swap_buf_left() end,
        },
        {
            "<leader><leader>Down",
            function() require("smart-splits").swap_buf_down() end,
        },
        { "<leader><leader>Up", function() require("smart-splits").swap_buf_up() end },
        {
            "<leader><leader>Left",
            function() require("smart-splits").swap_buf_right() end,
        },
    },
    config = function()
        require("smart-splits").setup({
            multiplexer_integration = true,
            zellij_move_focus_or_tab = true,
        })
    end,
}
