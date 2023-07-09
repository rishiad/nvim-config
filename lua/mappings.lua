local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Telescope Keybindings
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
keymap("n", "<leader>fb", ":Telescope file_browser<CR>", { noremap = true })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- Bufferline
keymap('n', '<S-Tab>', ':bprevious<CR>', default_opts)
keymap('n', '<Tab>', ':bnext<CR>', default_opts)