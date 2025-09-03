return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>a", function() require("harpoon"):list():add() end },
    {
      "<A-;>",
      function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
    },
    { "<A-h>", function() require("harpoon"):list():select(1) end },
    { "<A-t>", function() require("harpoon"):list():select(2) end },
    { "<A-n>", function() require("harpoon"):list():select(3) end },
    { "<A-s>", function() require("harpoon"):list():select(4) end },

    -- Toggle previous & next buffers stored within require("harpoon") list
    { "<C-.>", function() require("harpoon"):list():prev() end },
    { "<C-,>", function() require("harpoon"):list():next() end },
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function() return vim.loop.cwd() end,
      },
    })
  end,
}
