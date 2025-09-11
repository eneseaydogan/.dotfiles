return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- event = { "VeryLazy" },
  cmd = { "FzfLua" },
  keys = {
    {
      "<A-o>",
      function() require("fzf-lua").files({ hidden = false }) end,
      mode = "n",
      desc = "Fzf Files",
    },
    {
      "<A-f>",
      function() require("fzf-lua").files({ cwd = "~" }) end,
      mode = "n",
      desc = "Fzf Files",
    },
    {
      "<A-S-o>",
      function() require("fzf-lua").files({ hidden = true }) end,
      mode = "n",
      desc = "Fzf Files",
    },
    {
      "<leader>s",
      function() require("fzf-lua").lsp_document_symbols() end,
      mode = "n",
      desc = "Fzf Symbols",
    },
    {
      "<A-b>",
      function() require("fzf-lua").buffers() end,
      mode = "n",
      desc = "Fzf Buffers",
    },
    {
      "<A-g>",
      function() require("fzf-lua").live_grep() end,
      mode = "n",
      desc = "Fzf Grep",
    },
    {
      "<leader>dd",
      function() require("fzf-lua").diagnostics_document() end,
      mode = "n",
      desc = "Fzf diagnostics document",
    },
    {
      "<leader>dw",
      function() require("fzf-lua").diagnostics_workspace() end,
      mode = "n",
      desc = "Fzf diagnostics workspace",
    },
    {
      "<S-z>",
      function() require("fzf-lua").zoxide() end,
      mode = "n",
      desc = "Fzf zoxide",
    },
  },
  config = function()
    require("fzf-lua").setup({
      "max-perf",
      winopts = {
        border = "none",
      },
    })
    require("fzf-lua").register_ui_select()
  end,
}
