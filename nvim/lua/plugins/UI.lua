-- lua/plugins/UI.lua
-- plugins related to UI

return {
	-- tokyonight.nvim
	-- ui theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({ style = "night" })
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	-- lualine.nvim
	-- enhanced status bar
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = { theme = "tokyonight" },
		},
	},
	-- nvim-tree.lua
	-- file explorer for neovim
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- disable netrw
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({
				update_focused_file = {
					enable = true,
					update_cwd = true,
				},
			})

			vim.keymap.set(
				"n",
				"<leader>e",
				":NvimTreeToggle<CR>",
				{ noremap = true, silent = true, desc = "Toggle NvimTree" }
			)
		end,
	},
	-- indent-blankline.nvim
	-- indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = {
				show_exact_scope = true,
				highlight = { "Function", "Label" },
			},
		},
	},
	-- actions-preview.nvim
	-- a brand new ui for code actions
	{
		"aznhe21/actions-preview.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			vim.keymap.set(
				{ "v", "n" },
				"<leader>ca",
				require("actions-preview").code_actions,
				{ desc = "show code actions" }
			)

			require("actions-preview").setup({
				diff = {
					algorithm = "patience",
					ignore_whitespace = true,
				},
				-- create a ui looks like README
				telescope = {
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						width = 0.8,
						height = 0.9,
						prompt_position = "top",
						preview_cutoff = 20,
						preview_height = function(_, _, max_lines)
							return max_lines - 15
						end,
					},
				},
			})
		end,
	},
	-- bufferline.nvim
	-- a bufferline for nvim
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/which-key.nvim",
		},
		config = function()
			require("bufferline").setup({})
			-- numerical key to buffer mappings by which-key
			require("which-key").add({
				"<leader>b",
				group = "buffers",
				expand = function()
					return require("which-key.extras").expand.buf()
				end,
			})

			-- customized keymap
			vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
			vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
			vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })
		end,
	},
	-- noice.nvim
	-- new ui for messages, cmdline and popupmenu
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
}
