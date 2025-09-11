return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    { "rafamadriz/friendly-snippets" },
    "onsails/lspkind.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "Kaiser-Yang/blink-cmp-dictionary",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "windwp/nvim-autopairs",
      canfig = true,
      opts = {},
    },
  },
  version = "1.*",
  build = "cargo build --release",
  opts = {
    keymap = {
      preset = "enter",
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      -- trigger = { show_in_snippet = false },
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true },
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then icon = dev_icon end
                else
                  icon = require("lspkind").symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end

                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then hl = dev_hl end
                end
                return hl
              end,
            },
          },
        },
      },
    },
    sources = {
      default = { "lsp", "snippets", "path", "buffer" },
      per_filetype = {
        markdown = { inherit_defaults = true, "dictionary" },
      },
      providers = {
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          min_keyword_length = 3,
          opts = {
            dictionary_files = {
              vim.fn.expand("/usr/share/dict/usa"),
            },
            get_command_args = function(prefix, _)
              return {
                "--filter=" .. prefix,
                "--sync",
                "--no-sort",
                "-i", -- -i to ignore case, +i to respect case, with no this line is smart case
              }
            end,
          },
          -- keep case of first char
          transform_items = function(a, items)
            local keyword = a.get_keyword()
            local correct, case
            if keyword:match("^%l") then
              correct = "^%u%l+$"
              case = string.lower
            elseif keyword:match("^%u") then
              correct = "^%l+$"
              case = string.upper
            else
              return items
            end

            -- avoid duplicates from the corrections
            local seen = {}
            local out = {}
            for _, item in ipairs(items) do
              local raw = item.insertText
              if raw:match(correct) then
                local text = case(raw:sub(1, 1)) .. raw:sub(2)
                item.insertText = text
                item.label = text
              end
              if not seen[item.insertText] then
                seen[item.insertText] = true
                table.insert(out, item)
              end
            end
            return out
          end,
        },
        buffer = {
          opts = {
            get_bufnrs = function()
              return vim.tbl_filter(
                function(bufnr) return vim.bo[bufnr].buftype == "" end,
                vim.api.nvim_list_bufs()
              )
            end,
          },
        },
      },
    },
    fuzzy = {
      implementation = "rust",
      sorts = {
        "score",
        "exact",
      },
    },
    cmdline = {
      keymap = { preset = "inherit", ["<Tab>"] = { "show", "accept" }, ["<CR>"] = {} },
      completion = {
        menu = { auto_show = true },
        ghost_text = { enabled = true },
      },
    },
  },
  opts_extend = { "sources.default" },
}
