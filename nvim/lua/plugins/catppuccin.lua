return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      flavour = "mocha",
      styles = {
        comments = { "italic" }, -- Keep italic for visual distinction
        conditionals = { "bold" }, -- Make if/else/switch stand out
        loops = { "bold" }, -- Make for/while/repeat prominent
        functions = { "bold" }, -- Function names easier to spot
        keywords = { "bold" }, -- Language keywords more visible
        strings = {}, -- Keep normal for readability
        variables = {}, -- Keep normal to avoid clutter
        numbers = { "bold" }, -- Make constants stand out
        booleans = { "bold" }, -- true/false more prominent
        properties = { "italic" }, -- Object properties slightly emphasized
        types = { "bold" }, -- Data types more visible
        operators = {}, -- Keep normal to avoid visual noise
      },
      color_overrides = {
        mocha = {
          text = "#e8e8e8", -- Bright neutral grey for main text
          subtext1 = "#c8c8c8", -- Medium-light grey
          subtext0 = "#a8a8a8", -- Medium grey for hierarchy
          overlay2 = "#888888", -- Neutral mid-grey
          overlay1 = "#6c6c6c", -- Darker grey for subtle elements
          overlay0 = "#545454", -- Dark grey for borders/dividers
          surface2 = "#404040", -- Dark surface grey
          surface1 = "#2a2a2a", -- Darker surface
          surface0 = "#1a1a1a", -- Very dark grey background
          base = "#121212", -- Near-black grey base
          mantle = "#0a0a0a", -- Deeper grey
          crust = "#050505", -- Darkest grey, not pure black
        },
      },
      default_integrations = false,
      auto_integrations = true,
      integrations = {
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
