-- nvim/lua/plugins/COD.lua
-- plugins that directly related to code(insert mode)

return {
	-- blink.cmp
	-- auto completion
	-- TODO: add fzf and lsp capability to blink
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			-- enable integrability with nvim-cmp sources
			{ "saghen/blink.compat", version = "*" },
			-- TODO: config LuaSnip
			-- add a new config of LuaSnip elsewhere
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
			-- dictionary
			{
				"Kaiser-Yang/blink-cmp-dictionary",
				dependencies = "nvim-lua/plenary.nvim",
			},
			-- emoji
			{ "moyiz/blink-emoji.nvim" },
			-- latex symbols
			{ "kdheepak/cmp-latex-symbols" },
		},

		-- use a release tag to download pre-built binaries
		version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = {
				preset = "none",

				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-q>"] = { "hide" },
				["<CR>"] = { "accept", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = {
				list = {
					selection = { preselect = false, auto_insert = true },
				},
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 2 },
							{ "source_name" },
						},
						treesitter = { "lsp" },
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},

			cmdline = {
				completion = {
					list = {
						selection = { preselect = false, auto_insert = true },
					},
					menu = {
						auto_show = function()
							return vim.fn.getcmdtype() == ":"
						end,
					},
				},
			},
			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			snippets = { preset = "luasnip" },
			sources = {
				-- dynamic sources
				default = function()
					if vim.bo.filetype == "markdown" then
						return { "latex_symbols", "emoji", "dictionary", "path", "snippets", "buffer" }
					else
						return { "lazydev", "dictionary", "emoji", "lsp", "path", "snippets", "buffer" }
					end
				end,
				providers = {
					-- lazydev
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					dictionary = {
						module = "blink-cmp-dictionary",
						name = "Dict",
						-- Make sure this is at least 2.
						-- 3 is recommended
						min_keyword_length = 4,
						max_items = 8,
						score_offset = -10,
						opts = {
							-- options for blink-cmp-dictionary
							dictionary_directories = { vim.fn.expand("~/.config/nvim/dict") },
						},
					},
					-- emoji
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15, -- Tune by preference
						opts = { insert = true }, -- Insert emoji (default) or complete its name
						should_show_items = function()
							return vim.tbl_contains(
								-- Enable emoji completion only for git commits and markdown.
								-- By default, enabled for all file-types.
								{ "gitcommit", "markdown" },
								vim.o.filetype
							)
						end,
					},
					-- latex symbols
					latex_symbols = {
						name = "latex_symbols",
						module = "blink.compat.source",
						opts = {
							strategy = 2,
						},
					},
				},
			},
			-- enable signature help
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
	-- conform.nvim
	-- code formatter
	{
		"stevearc/conform.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufReadPost" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				markdown = { "prettierd" },

				-- the config filetypes
				yaml = { "prettierd" },
				toml = { "taplo" },
				lua = { "stylua" },

				-- cpp and c formatting have done by LSPs
				-- cpp = { "clangd" },
				-- c = { "clangd" },
				-- python = { "isort", "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500 },
			-- Customize formatters
			formatters = {
				taplo = {
					command = "taplo",
					-- stylua: ignore 
					args = {
						"format",
						"--option", "align_entries=true",
						"--option", "indent_string=\t",
						"-",
					},
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	-- mason-conform
	-- automatically download formatters in conform configs in mason
	{
		"zapling/mason-conform.nvim",
		dependencies = { "stevearc/conform.nvim" },
		opts = {},
	},
	-- nvim-autopairs
	-- autopair for multiple characters
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = { check_ts = true },
	},
	-- mini.surround
	-- surround actions
	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {
			mappings = {
				add = "<leader>sa", -- Add surrounding in Normal and Visual modes
				delete = "<leader>sd", -- Delete surrounding
				find = "<leader>sf", -- Find surrounding (to the right)
				find_left = "<leader>sF", -- Find surrounding (to the left)
				highlight = "<leader>sh", -- Highlight surrounding
				replace = "<leader>sr", -- Replace surrounding
				update_n_lines = "<leader>sn", -- Update `n_lines`
			},
		},
	},
}
