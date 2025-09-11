return {
  "emmanueltouzery/apidocs.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
  },
  cmd = { "ApidocsSearch", "ApidocsInstall", "ApidocsOpen", "ApidocsSelect", "ApidocsUninstall" },
  config = function()
    local ad = require("apidocs")
    ad.setup({ picker = "ui_select" })
    ad.ensure_install({
      "c",
      "go",
      "lua~5.4",
    })
  end,
  keys = {
    { "<A-d>", "<cmd>ApidocsOpen<cr>", desc = "Search Api Doc" },
  },
}
