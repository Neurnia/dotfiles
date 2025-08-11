-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- some basic settings for vim
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.foldenable = false

-- better window motions
local map = vim.keymap.set

-- Window navigation
map("n", "<leader>wh", "<C-w>h", { noremap = true, desc = "Go to the left window" })
map("n", "<leader>wj", "<C-w>j", { noremap = true, desc = "Go to the down window" })
map("n", "<leader>wk", "<C-w>k", { noremap = true, desc = "Go to the up window" })
map("n", "<leader>wl", "<C-w>l", { noremap = true, desc = "Go to the right window" })

-- Move window to far edge
map("n", "<leader>wH", "<C-w>H", { noremap = true, desc = "Move window to far left" })
map("n", "<leader>wJ", "<C-w>J", { noremap = true, desc = "Move window to far bottom" })
map("n", "<leader>wK", "<C-w>K", { noremap = true, desc = "Move window to far top" })
map("n", "<leader>wL", "<C-w>L", { noremap = true, desc = "Move window to far right" })

-- Window layout
map("n", "<leader>wo", "<C-w>o", { noremap = true, desc = "Close all other windows" })
map("n", "<leader>wq", "<C-w>q", { noremap = true, desc = "Quit a window" })
map("n", "<leader>ws", "<C-w>s", { noremap = true, desc = "Split window" })
map("n", "<leader>wv", "<C-w>v", { noremap = true, desc = "Split window vertically" })
map("n", "<leader>wT", "<C-w>T", { noremap = true, desc = "Break out into a new tab" })
map("n", "<leader>ww", "<C-w>w", { noremap = true, desc = "Switch windows" })
map("n", "<leader>wx", "<C-w>x", { noremap = true, desc = "Swap current with next" })

-- Resize windows
map("n", "<leader>w+", "<C-w>+", { noremap = true, desc = "Increase height" })
map("n", "<leader>w-", "<C-w>-", { noremap = true, desc = "Decrease height" })
map("n", "<leader>w<", "<C-w><", { noremap = true, desc = "Decrease width" })
map("n", "<leader>w=", "<C-w>=", { noremap = true, desc = "Equally high and wide" })
map("n", "<leader>w>", "<C-w>>", { noremap = true, desc = "Increase width" })
map("n", "<leader>w_", "<C-w>_", { noremap = true, desc = "Max out the height" })
map("n", "<leader>w|", "<C-w>|", { noremap = true, desc = "Max out the width" })

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
	git = {
		url_format = "https://github.com/%s.git",
	},
})

-- Special setup for Lazy
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { noremap = true, silent = true, desc = "Open Lazy" })
