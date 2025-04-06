-- nvim/lua/plugins/LSP.lua
-- plugins related to LSPs

return {
	-- mason.nvim
	-- auto management of LSPs
	-- need to be loaded first in LSP-related plugins
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
		keys = {
			-- set keymap for open mason ui
			{ "<leader>cm", "<cmd>Mason<CR>", noremap = true, silent = true, desc = "Open Mason" },
		},
	},
	-- mason-lspconfig.nvim
	-- connect mason and lspconfig to make a smoother LSP configurating experience
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			-- define the handlers
			local handlers = {
				-- default handler for servers without a dedicated handler
				function(server_name)
					lspconfig[server_name].setup({})
				end,

				-- lua_ls for lua
				-- no need to config anything else thanks to lazydev.nvim!!!
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									-- but i have to disable this annoying diagnostics!!
									disable = { "missing-fields" },
								},
							},
						},
					})
				end,

				-- ltex for the english language
				["ltex"] = function()
					lspconfig.ltex.setup({
						on_attach = function()
							require("ltex_extra").setup({
								path = vim.fn.stdpath("config") .. "/dict",
							})
						end,
						settings = {
							ltex = {
								language = "en-US",
							},
						},
					})
				end,

				-- add new configs for new servers here
			}
			-- setup the plugin
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- NOTE: add new LSPs here
					"lua_ls",
					"clangd",
					"texlab",
					"ltex",
				},
				automatic_installation = true,
				handlers = handlers,
			})
		end,
	},
	-- nvim-lspconfig
	-- enables detailed configuration for LSPs
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			-- compensate for the shortcomings of ltex in Neovim
			"barreiroleo/ltex_extra.nvim",
		},
		config = function()
			-- NOTE: config some nvim's builtin LSP-related things here
			vim.diagnostic.config({
				virtual_lines = { current_line = true },
			})
		end,
		-- lsp keymaps
		keys = {
			{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
			-- { "gi", vim.lsp.buf.implementation, desc = "Go to Implementation" },
			-- { "gr", vim.lsp.buf.references, desc = "Show References" },
			{ "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
			{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename Symbol" },
		},
	},
	-- lazydev.nvim
	-- add VIMRUNTIME library and other 3rd party libraries to lua_ls
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- nvim-treesitter
	-- enhanced treesitter experience
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local parsers = {
				"c",
				"cpp",
				"lua",
				"python",
				"markdown",
				"markdown_inline",
				"latex",
				"html",
				"vim",
				"regex",
				"bash",
			}

			require("nvim-treesitter.configs").setup({
				ensure_installed = parsers,
				highlight = { enale = true },
				indent = { enable = true },
			})
		end,
	},
}
