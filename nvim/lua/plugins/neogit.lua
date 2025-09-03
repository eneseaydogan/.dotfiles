return {
  "NeogitOrg/neogit",
  cmd = { "Neogit" },
  keys = {
    {
      "<leader>ng",
      function() require("neogit").open() end,
      mode = "n",
      desc = "Open NeoGit",
    },
  },
  dependencies = {
    {
      "sindrets/diffview.nvim",
      opts = {
        hooks = {
          diff_buf_read = function() vim.opt_local.wrap = false end,
          diff_buf_win_enter = function(bufnr, winid, ctx)
            if ctx.layout_name:match("^diff2") then
              if ctx.symbol == "a" then
                vim.opt_local.winhl = table.concat({
                  "DiffAdd:DiffviewDiffAddAsDelete",
                  "DiffDelete:DiffviewDiffDelete",
                  "DiffChange:DiffAddAsDelete",
                  "DiffText:DiffDeleteText",
                }, ",")
              elseif ctx.symbol == "b" then
                vim.opt_local.winhl = table.concat({
                  "DiffDelete:DiffviewDiffDelete",
                  "DiffChange:DiffAdd",
                  "DiffText:DiffAddText",
                }, ",")
              end
            end
          end,
        },
      },
      keys = {
        {
          "<leader>qd",
          "<cmd>DiffviewClose<cr>",
          mode = "n",
          desc = "Open NeoGit",
        },
      },
    },
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
  },
}
