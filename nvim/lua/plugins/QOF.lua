-- nvim/lua/plugins/QOF.lua
-- plugins related to quality of life

return {
	-- flash.nvim
	-- smart jump
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = { modes = { search = { enabled = true } } },
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},
	-- which-key.nvim
	-- that famous plugin
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local map = require("which-key")

			map.add({
				{ "<leader>c", group = "codes" },
				{ "<leader>g", group = "git" },
				{ "<leader>s", group = "surrounds" },
				{ "<leader>w", group = "window" },
			})
		end,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	-- yazi.nvim
	-- yazi just inside neovim
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "folke/snacks.nvim", lazy = true },
			"folke/which-key.nvim",
		},
		config = function()
			require("which-key").add({ "<leader>y", group = "yazi" })
		end,
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>yf",
				mode = "n",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>yd",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<leader>yr",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},
	-- todo-comments.nvim
	-- Highlight, list and search todo comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		-- keymaps for todo-comments
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
		},
	},
	-- markdown-preview.nvim
	-- using browser to preview markdown files
	{
		"iamcco/markdown-preview.nvim",
		pin = true,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		-- keymap for markdown-preview
		keys = {
			{
				"<leader>cM",
				"<cmd>MarkdownPreviewToggle<cr>",
				mode = { "n", "v" },
				desc = "Toggle markdown preview",
			},
		},
	},
	-- grug-far.nvim
	-- find and replace plugin for neovim
	{
		"MagicDuck/grug-far.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
		-- keymaps for grug-far
		keys = {
			{
				"<leader>cR",
				"<cmd>GrugFar<cr>",
				mode = "n",
				desc = "Search and replace",
			},
			{
				"<leader>cR",
				"<cmd>GrugFarWithIn<cr>",
				mode = "v",
				desc = "Search and replace selected",
			},
		},
	},
}
