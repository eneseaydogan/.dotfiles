return {
  "mfussenegger/nvim-lint",
  event = { "BufWrite", "BufWritePost" },
  config = function()
    require("lint").linters_by_ft = {
      -- c = { "clangtidy" },
      bash = { "shellcheck" },
      make = { "checkmake" },
      COMMIT_EDITMSG = { "commitlint" },
      go = { "golangcilint" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function() require("lint").try_lint() end,
    })
  end,
}
