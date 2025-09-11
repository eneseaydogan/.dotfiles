local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<C-b>", "<C-v>", { noremap = true })

-- Scroll Half and center
map("n", "<S-down>", "<C-d>zz")
map("n", "<S-up>", "<C-u>zz")

-- Move Lines
map("n", "<C-S-down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<C-S-up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<C-S-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<C-S-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map(
  "v",
  "<C-S-down>",
  ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
  { desc = "Move Down" }
)
map(
  "v",
  "<C-S-up>",
  ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
  { desc = "Move Up" }
)

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map(
  "n",
  "n",
  "'Nn'[v:searchforward].'zv'",
  { expr = true, silent = true, desc = "Next Search Result" }
)
map("x", "n", "'Nn'[v:searchforward]", { expr = true, silent = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, silent = true, desc = "Next Search Result" })
map(
  "n",
  "N",
  "'nN'[v:searchforward].'zv'",
  { expr = true, silent = true, desc = "Prev Search Result" }
)
map("x", "N", "'nN'[v:searchforward]", { expr = true, silent = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, silent = true, desc = "Prev Search Result" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Replace a word with yanked text
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', opts)

-- Windows
map("n", "<C-m>", "<C-w>s", { desc = "Split window below" })
map("n", "<C-n>", "<C-w>v", { desc = "Split window right" })
map("n", "<C-c>", "<C-w>c", { desc = "Close current window" })
map("n", "<C-f>", "<C-w><C-w>")

-- Tabs
map("n", "<leader>ta", ":$tabnew<CR>", { noremap = true, silent = true })
map("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true })
map("n", "<leader>to", ":tabonly<CR>", { noremap = true, silent = true })
map("n", "<leader>tn", ":tabn<CR>", { noremap = true, silent = true })
map("n", "<leader>tp", ":tabp<CR>", { noremap = true, silent = true })
map("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true, silent = true })
map("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true, silent = true })

-- Terminal
map("t", "<Esc>", [[<C-\><C-n>]]) -- Escape to normal mode in terminal

map("v", "<leader>rv", '"hy:%s/\\V<C-r>h/<C-r>h/gc<left><left><left>')
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map("n", "<leader>w", ":w<cr>", opts)
