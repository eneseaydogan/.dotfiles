return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  keys = {
    {
      "<leader>f",
      function() require("conform").format() end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters = {
        -- bake = {
        --   meta = {
        --     url = "https://github.com/EbodShojaei/bake",
        --     description = "A Makefile formatter and linter.",
        --   },
        --   command = "mbake",
        --   args = { "format", "$FILENAME" },
        --   stdin = false,
        -- },
      },
      formatters_by_ft = {
        c = { "clang_format" },
        lua = { "stylua" },
        -- make = { "bake" },
        markdown = { "prettier" },
        go = { "goimports", "gofmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        kdl = { "kdlfmt" },
        toml = { "taplo" },
        fish = { "fish_indent" },
        -- ["*"] = { "injected" },
      },
      default_format_opts = {
        lsp_format = "fallback",
        async = true,
      },
    })
  end,
}
