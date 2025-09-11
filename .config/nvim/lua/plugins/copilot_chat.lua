return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  keys = {
    {
      "<A-c>",
      ":CopilotChatToggle<cr>",
      desc = "Toggal chat window",
    },
  },
  opts = {
    -- model = "gpt-5-mini",
    model = "gpt-5",
    temperature = 0.20,
    window = {
      layout = "vertical",
      width = 0.5,
    },
    auto_insert_mode = false,
    highlight_headers = false,
    separator = "---",
    error_header = "> [!ERROR] Error",
  },
}
