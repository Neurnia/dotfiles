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
						settings = {
							ltex = {
								language = "en",
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
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			-- lsp keymap
			vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", {
				noremap = true,
				silent = true,
				desc = "definition",
			})
		end,
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
