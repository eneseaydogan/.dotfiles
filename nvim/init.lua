vim.loader.enable()
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ","
require("lazy")
require("options")
require("maps")
require("autocmds")
