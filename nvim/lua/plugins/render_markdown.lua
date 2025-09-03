return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ft = { "markdown", "md", "copilot-chat" },
  opts = {
    latex = { enabled = false },
    heading = {
      width = "block",
      left_pad = 2,
      right_pad = 4,
      border = true,
      border_virtual = true,
    },
    code = {
      language_border = " ",
      language_left = "",
      language_right = "",
      width = "block",
      left_pad = 2,
      right_pad = 4,
    },
    dash = {
      width = 30,
    },
    pipe_table = {
      preset = "round",
      min_width = 15,
    },

    completions = { lsp = { enabled = true }, blink = { enabled = true } },
    render_modes = true,
    checkbox = {
      enabled = true,
      render_modes = false,
      bullet = false,
      right_pad = 1,
      unchecked = {
        icon = "󰄱 ",
        highlight = "RenderMarkdownUnchecked",
        scope_highlight = nil,
      },
      checked = {
        icon = "󰱒 ",
        highlight = "RenderMarkdownChecked",
        scope_highlight = "@markup.strikethrough",
      },
      custom = {
        todo = {
          raw = "[-]",
          rendered = "󰥔 ",
          highlight = "RenderMarkdownTodo",
          scope_highlight = nil,
        },
      },
    },
  },
}
