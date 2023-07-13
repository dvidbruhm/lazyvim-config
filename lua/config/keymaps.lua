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
