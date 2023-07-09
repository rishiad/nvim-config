-- Lazy
local LAZY_PATH = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local LAZY_REPO = "https://github.com/folke/lazy.nvim.git"
-- Theme
local theme = require("theme")

-- Check if lazy.nvim is installed
if not vim.loop.fs_stat(LAZY_PATH) then
	print("Could not find lazy.nvim at " .. LAZY_PATH)
	print("Coloning lazy.nvim from " .. LAZY_REPO)
	vim.fn.system({ "git", "clone", "--filter=blob:none", LAZY_REPO, "--branch=stable", LAZY_PATH })
end

vim.opt.rtp:prepend(LAZY_PATH)

-- Load lazy.nvim
local ok, lazy = pcall(require, "lazy")

if not ok then
	print("Could not load lazy.nvim")
	print(lazy)
	return
end

-- Plugins
local plugins = {
	-- UI
	theme.get_active_theme(),
	"kyazdani42/nvim-web-devicons",
	"onsails/lspkind.nvim",
	require("plugins.configs.bufferline"),
	-- Plenary
	"nvim-lua/plenary.nvim",
	-- Treesitter
	require("plugins.configs.treesitter"),
	-- Telescope
	require("plugins.configs.telescope"),
	-- Telescope File Browser
	require("plugins.configs.telescopefb"),
	-- LSP
	"neovim/nvim-lspconfig",
	require("plugins.configs.mason"),
	require("plugins.configs.null-ls"), -- Extends LSP function with external tools
	require("plugins.configs.rust-tools"),
	-- Debug
	require("lsp.configs.dap"),
	require("lsp.configs.dap-py"),
	require("plugins.configs.telescopedap"),
	-- Snippet Engine
	require("plugins.configs.luasnip"),
	-- Snippet Sources
	"iurimateus/luasnip-latex-snippets.nvim",
	"rafamadriz/friendly-snippets",
	-- Autocomplete
	require("plugins.configs.cmp"),
	require("plugins.configs.autopairs"),
	"hrsh7th/cmp-nvim-lsp", -- LSP source
	"saadparwaiz1/cmp_luasnip", -- Snippets source
	"hrsh7th/cmp-buffer", -- Buffer source
	"onsails/lspkind-nvim", -- LSP icons
	"hrsh7th/cmp-nvim-lua", -- nvim lua api source
}

lazy.setup(plugins)
