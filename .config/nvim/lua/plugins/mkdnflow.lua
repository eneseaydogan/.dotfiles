return {
  "jakewvincent/mkdnflow.nvim",
  ft = { "markdown" },
  config = function()
    require("mkdnflow").setup({
      perspective = {
        priority = "first",
      },
      links = {
        style = "markdown",
        transform_explicit = function(text)
          text = text:gsub(" ", "-")
          text = text:lower()
          return text
        end,
      },
      to_do = {
        symbols = { " ", "-", "X" },
        update_parents = true,
        not_started = " ",
        in_progress = "-",
        complete = "X",
      },
      tables = {
        trim_whitespace = true,
        format_on_move = true,
        -- auto_extend_rows = true,
        -- auto_extend_cols = true,
        style = {
          cell_padding = 1,
          separator_padding = 1,
          outer_pipes = true,
          mimic_alignment = true,
        },
      },
      mappings = {
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
      },
    })
  end,
}
