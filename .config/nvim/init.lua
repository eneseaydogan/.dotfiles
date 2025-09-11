vim.loader.enable()
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ","
require("config.lazy")
require("config.options")
require("config.maps")
require("config.autocmds")
