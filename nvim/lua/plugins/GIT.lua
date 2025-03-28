-- nvim/lua/plugins/GIT.lua
-- plugins directly related to git

return {
	-- gitsigns.nvim
	-- the one-and-only git-related plugin people must install
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs_staged_enable = true,
			signcolumn = true,
			numhl = true,
			on_attach = function()
				-- keymaps
				local gitsigns = require("gitsigns")
				vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, { desc = "Git blame line" })
				vim.keymap.set("n", "<leader>gh", gitsigns.preview_hunk_inline, { desc = "Git preview hunk" })
			end,
		},
	},
	-- lazygit.nvim
	-- open up lazygit in nvim
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	-- diffview.nvim
	-- Single tabpage interface for easily cycling through diffs
	{
		"sindrets/diffview.nvim",
		opts = {},
		config = function()
			-- add custom key to call diffview
			vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { silent = true, desc = "Git diffview" })
			vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { silent = true, desc = "Close diffview" })
			vim.keymap.set(
				"n",
				"<leader>gf",
				"<cmd>DiffviewFileHistory<cr>",
				{ silent = true, desc = "Git file history diffview" }
			)
		end,
	},
}
