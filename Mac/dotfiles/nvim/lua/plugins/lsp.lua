return {
	"neovim/nvim-lspconfig",
	version = "*",
	dependencies = {
		-- LSP + Mason
		{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				ensure_installed = { "lua_ls", "pyright", "ts_ls", "zls", "ltex", "marksman" },
			},
		},
		"j-hui/fidget.nvim",

		-- Formatting
		"stevearc/conform.nvim",

		-- Completion
		{ "hrsh7th/nvim-cmp", event = { "InsertEnter", "CmdlineEnter" } },
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
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
				r = { "r_styler" },
				tex = { "latexindent" },
				latex = { "latexindent" },
			},
			default_format_opts = {
				lsp_format = "fallback",
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
				r_styler = {
					command = "Rscript",
					args = {
						"-e",
						"styler::style_file(commandArgs(trailingOnly = TRUE)[1])",
						"$FILENAME",
					},
					stdin = false,
				},
				latexindent = {
					command = "latexindent",
					args = { "-" },
					stdin = true,
					timeout_ms = 4000,
				},
			},
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

		-- Cmdline completion for "/" and "?" (search)
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Cmdline completion for ":" (command)
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		local cmp_enabled = true
		vim.keymap.set("n", "<leader>ltc", function()
			cmp_enabled = not cmp_enabled
			cmp.setup({ enabled = cmp_enabled })
			vim.notify("Suggestions: " .. (cmp_enabled and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
		end, { silent = true, desc = "Completion: toggle suggestions" })

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
			filetypes = { "lua" },
			root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", "stylua.toml", ".stylua.toml", ".git" },
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "bit", "vim", "it", "describe", "before_each", "after_each" } },
					workspace = { checkThirdParty = false },
				},
			},
		})

		-- Python
		local function get_python_path(workspace)
			-- 1. Respect VIRTUAL_ENV if already activated
			local venv = vim.env.VIRTUAL_ENV
			if venv then
				return venv .. "/bin/python"
			end

			-- 2. Auto-detect .venv in project root
			local venv_path = workspace .. "/.venv/bin/python"
			if vim.fn.executable(venv_path) == 1 then
				return venv_path
			end

			-- 3. Fallback to system python
			return vim.fn.exepath("python3") or "python"
		end

		vim.lsp.config("pyright", {
			filetypes = { "python" },
			root_markers = {
				"pyrightconfig.json",
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				"Pipfile",
				".git",
			},
			on_init = function(client)
				local root = client.config.root_dir or vim.fn.getcwd()
				local python_path = get_python_path(root)
				client.config.settings.python.pythonPath = python_path
			end,
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

		-- TypeScript/JavaScript
		vim.lsp.config("ts_ls", {
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
		})

		-- LTEX
		vim.lsp.config("ltex", {
			filetypes = { "markdown", "text", "tex", "latex", "bib" },
			root_markers = { ".git" },
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
			filetypes = { "zig", "zir" },
			root_markers = { "zls.json", "build.zig", ".git" },
			settings = {
				zls = {
					enable_inlay_hints = true,
					enable_snippets = true,
					warn_style = true,
				},
			},
		})

		-- Marksman
		vim.lsp.config("marksman", {
			filetypes = { "markdown" },
			root_markers = { ".git", ".marksman.toml", "index.md" },
		})

		-- Enable all Mason-managed servers
		vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "zls", "ltex", "marksman" })

		-- R (installed via R, not Mason)
		-- Use autocmd to explicitly start server since it's not managed by Mason
		local r_lsp_group = vim.api.nvim_create_augroup("RLanguageServer", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			group = r_lsp_group,
			pattern = { "r" },
			callback = function()
				-- Find git root or use cwd
				local root_dir = vim.fn.getcwd()
				local git = vim.fs.find(".git", { upward = true })[1]
				if git then
					root_dir = vim.fs.dirname(git)
				end

				vim.lsp.start({
					name = "r_language_server",
					cmd = { "R", "--slave", "-e", "languageserver::run()" },
					root_dir = root_dir,
				})
			end,
		})

		----------------------------------------------------------------------
		-- LSP attach behavior
		----------------------------------------------------------------------
		local lsp_attach_group = vim.api.nvim_create_augroup("LspAttachKeymaps", { clear = true })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = lsp_attach_group,
			callback = function(ev)
				local bufnr = ev.buf

				local function nmap(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
				end

			-- Hover, rename, code action
			nmap("<leader>ld", vim.lsp.buf.hover, "Hover")
			nmap("<leader>lrn", vim.lsp.buf.rename, "Rename")
			nmap("<leader>lca", vim.lsp.buf.code_action, "Code Action")

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
