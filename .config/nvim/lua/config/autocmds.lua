local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set
local opts = { silent = true }

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  callback = function()
    if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function() (vim.hl or vim.highlight).on_yank() end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
  pattern = { "json", "jsonc", "json5" },
  callback = function() vim.opt_local.conceallevel = 0 end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

autocmd({ "BufWritePre" }, {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    map("n", "<leader>d", vim.lsp.buf.definition, bufopts)
    map("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    map("n", "<leader>h", vim.lsp.buf.hover, bufopts)
    map("n", "<leader>r", vim.lsp.buf.references, bufopts)
    map("n", "<leader>i", vim.lsp.buf.implementation, bufopts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    map("n", "<leader>e", vim.diagnostic.open_float, bufopts)
    map("n", "<leader>q", vim.diagnostic.setloclist, bufopts)
    map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    if client.server_capabilities.codeLensProvider then
      map("n", "<leader>cl", vim.lsp.codelens.run, { buffer = bufnr, desc = "Run CodeLens" })
      map(
        "n",
        "<leader>cr",
        vim.lsp.codelens.refresh,
        { buffer = bufnr, desc = "Refresh CodeLens" }
      )

      local group = vim.api.nvim_create_augroup("LspCodeLens" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = group,
        buffer = bufnr,
        callback = function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt.expandtab = false
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 0
  end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function() vim.cmd([[Trouble qflist open]]) end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.sway",
    callback = function()
        vim.bo.filetype = "swayconfig"
    end,
})
