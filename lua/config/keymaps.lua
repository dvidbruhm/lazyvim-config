-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
---- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- unset s
map({ "n", "x", "v" }, "s", "<Nop>")

-- see line diagnostics
map("n", "gl", vim.diagnostic.open_float, { desc = "See line diagnostics" })

-- change buffer
map("n", "<S-right>", ":bnext<CR>")
map("n", "<S-left>", ":bprevious<CR>")

-- Move Lines
map("n", "<A-S-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-S-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("v", "<A-S-down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-S-up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map("i", "<A-S-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-S-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })

-- better indenting
map("v", "<tab>", ">gv")
map("v", "<S-tab>", "<gv")

-- better up/down
map("n", "<S-up>", "<C-u>")
map("n", "<S-down>", "<C-d>")

-- delete a word (might have to configure terminal for this to work)
map("i", "<C-BS>", "<C-w>")

-- floating terminal
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end
map({ "n", "t" }, "<F1>", function()
  require("nvterm.terminal").toggle("float")
end, { desc = "Terminal (root dir)" })
