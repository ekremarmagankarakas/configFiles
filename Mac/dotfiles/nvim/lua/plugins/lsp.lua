return {
	"neovim/nvim-lspconfig",
	version = "*",
	dependencies = {
		-- LSP + Mason
		{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				ensure_installed = { "lua_ls", "pyright", "ts_ls", "zls", "ltex" },
				automatic_enable = true,
			},
		},
		"j-hui/fidget.nvim",

		-- Formatting
		"stevearc/conform.nvim",

		-- Completion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		-- Telescope
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
	},

	config = function()
		--------------------------------------------------------------------------
		-- Conform (Formatting Only)
		--------------------------------------------------------------------------
		local conform = require("conform")
		local util = require("conform.util")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				cpp = { "clang_format" },
				javascript = { "eslint_d", "prettier" },
				typescript = { "eslint_d", "prettier" },
				typescriptreact = { "eslint_d", "prettier" },
				javascriptreact = { "eslint_d", "prettier" },
			},
			formatters = {
				ruff_format = {
					command = "ruff",
					args = { "format", "--stdin-filename", "$FILENAME" },
					stdin = true,
				},
				clang_format = {
					command = "clang-format",
					args = { "--assume-filename", "$FILENAME" },
					stdin = true,
				},
				prettier = { prepend_args = { "--tab-width", "2", "--use-tabs", "false" } },
				stylua = { prepend_args = { "--indent-width", "4" } },
				eslint_d = {
					command = "eslint_d",
					stdin = false,
					args = { "--fix", "--stdin-filename", "$FILENAME", "$FILENAME" },
					condition = function(ctx)
						if vim.fn.executable("eslint_d") ~= 1 then
							return false
						end
						return util.root_file({
							".eslintrc",
							".eslintrc.js",
							".eslintrc.cjs",
							".eslintrc.json",
							"eslint.config.js",
							"eslint.config.mjs",
							"eslint.config.cjs",
							"eslint.config.ts",
							"eslint.config.mts",
							"eslint.config.cts",
						}, ctx.buf) ~= nil
					end,
				},
			},
			default_formatter = "prettier",
		})

		vim.keymap.set("n", "<leader>lf", function()
			conform.format()
		end, { noremap = true, silent = true, desc = "Format file" })

		--------------------------------------------------------------------------
		-- CMP
		--------------------------------------------------------------------------
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
                { name = "path" },
			}, { { name = "buffer" } }),
		})

		----------------------------------------------------------------------
		-- LSP core
		----------------------------------------------------------------------
		require("fidget").setup()

		vim.lsp.config("*", {
			capabilities = cmp_lsp.default_capabilities(),
		})

		----------------------------------------------------------------------
		-- Server configs
		----------------------------------------------------------------------

		-- Lua
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "bit", "vim", "it", "describe", "before_each", "after_each" } },
					workspace = { checkThirdParty = false },
				},
			},
		})

		-- Python
		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "standard",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		-- LTEX
		vim.lsp.config("ltex", {
			settings = {
				ltex = {
					checkFrequency = "save",
					language = "en-US",
					enabled = { "markdown", "text", "tex" },
					disabledRules = { ["en-US"] = { "WHITESPACE_RULE" } },
				},
			},
		})

		-- Zig
		vim.lsp.config("zls", {
			settings = {
				zls = {
					enable_inlay_hints = true,
					enable_snippets = true,
					warn_style = true,
				},
			},
		})

		----------------------------------------------------------------------
		-- LSP attach behavior
		----------------------------------------------------------------------
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local bufnr = ev.buf
				local client = vim.lsp.get_client_by_id(ev.data.client_id)

				-- Conform handles formatting for these
				if client then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end

				local function nmap(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
				end

				-- Hover, rename, code action, diag float
				nmap("<leader>ld", vim.lsp.buf.hover, "Hover")
				nmap("<leader>lrn", vim.lsp.buf.rename, "Rename")
				nmap("<leader>lca", vim.lsp.buf.code_action, "Code Action")
				nmap("<leader>lef", function()
					vim.diagnostic.open_float(nil, { focusable = false })
				end, "Diagnostics Float")
				nmap("<leader>le", function()
					local width = math.min(math.floor(vim.o.columns * 0.8), 100)
					vim.diagnostic.open_float({
						focusable = true,
						max_width = width,
						wrap = true,
						border = "rounded",
						source = "always",
					})
				end, "Diagnostics Float")

				-- LSP pickers through Telescope (inherit global layout)
				local ok_tb, tb = pcall(require, "telescope.builtin")
				if ok_tb then
					if tb.diagnostics then
						nmap("<leader>lD", tb.diagnostics, "Diagnostics (Telescope)")
					else
						nmap("<leader>lD", function()
							vim.diagnostic.setqflist()
							vim.cmd("copen")
						end, "Diagnostics (Quickfix)")
					end

					nmap("<leader>lgd", tb.lsp_definitions, "Go to Definition")
					nmap("<leader>lgr", function()
						tb.lsp_references({ include_declaration = false })
					end, "References")
					nmap("<leader>lgi", tb.lsp_implementations, "Implementations")
					nmap("<leader>lgD", tb.lsp_type_definitions, "Type Definitions")
					nmap("<leader>ls", tb.lsp_document_symbols, "Document Symbols")
					nmap("<leader>lS", tb.lsp_workspace_symbols, "Workspace Symbols")
				else
					-- Fallbacks if Telescope is not present
					nmap("<leader>lgd", vim.lsp.buf.definition, "Go to Definition")
					nmap("<leader>lgr", function()
						vim.lsp.buf.references({ include_declaration = false })
					end, "References")
					nmap("<leader>lgi", vim.lsp.buf.implementation, "Implementations")
					nmap("<leader>lgD", vim.lsp.buf.type_definition, "Type Definitions")
				end
			end,
		})
	end,
}
