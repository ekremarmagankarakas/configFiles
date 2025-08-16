return {
	"neovim/nvim-lspconfig",
	version = "*",
	dependencies = {
		-- LSP and Mason
		"williamboman/mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", commit = "1a31f824b9cd5bc6f342fc29e9a53b60d74af245" },
		"j-hui/fidget.nvim",

		-- Formatting
		"stevearc/conform.nvim",

		-- Completion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"l3mon4d3/luasnip",
		"saadparwaiz1/cmp_luasnip",
	},

	config = function()
		--------------------------------------------------------------------------
		-- Formatting Setup (Conform)
		--------------------------------------------------------------------------
		local conform = require("conform")
		local util = require("conform.util")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format" },
				cpp = { "clang-format" },
				javascript = { "eslint_d", "prettier" },
				typescript = { "eslint_d", "prettier" },
				typescriptreact = { "eslint_d", "prettier" },
				javascriptreact = { "eslint_d", "prettier" },
			},
			formatters = {
				ruff_fix = {
					command = "ruff",
					args = { "check", "--fix", "--stdin-filename", "$FILENAME", "-" },
					stdin = true,
				},
				ruff_format = {
					command = "ruff",
					args = { "format", "--stdin-filename", "$FILENAME" },
					stdin = true,
				},
				prettier = { prepend_args = { "--tab-width", "2", "--use-tabs", "false" } },
				stylua = { prepend_args = { "--indent-width", "4" } },
				eslint_d = {
					command = "eslint_d",
					stdin = false,
					args = {
						"--fix",
						"--stdin-filename",
						"$FILENAME",
						"$FILENAME",
					},
					-- Only run if an ESLint config exists
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
			log_level = vim.log.levels.DEBUG,
		})

		-- Auto-format on save
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	pattern = "*",
		-- 	callback = function()
		-- 		require("conform").format()
		-- 	end,
		-- })

		-- Manual format keybinding
		vim.keymap.set("n", "<leader>lf", function()
			require("conform").format()
		end, { noremap = true, silent = true, desc = "Format file" })

		--------------------------------------------------------------------------
		-- Completion Setup (nvim-cmp)
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
				-- { name = "copilot" }, # CMP for copilot
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		--------------------------------------------------------------------------
		-- Diagnostic Settings
		--------------------------------------------------------------------------
		vim.diagnostic.config({
			virtual_text = false,
			underline = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Toggle virtual text
		local virtual_text_enabled = false
		vim.keymap.set("n", "<leader>lee", function()
			virtual_text_enabled = not virtual_text_enabled
			vim.diagnostic.config({ virtual_text = virtual_text_enabled })
			vim.notify("Virtual text: " .. (virtual_text_enabled and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
		end, { noremap = true, silent = true, desc = "Toggle virtual text for diagnostics" })

		-- Toggle underline
		local underline_enabled = true
		vim.keymap.set("n", "<leader>leu", function()
			underline_enabled = not underline_enabled
			vim.diagnostic.config({ underline = underline_enabled })
			vim.notify("Underline: " .. (underline_enabled and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
		end, { noremap = true, silent = true, desc = "Toggle underline for diagnostics" })

		-- Toggle completion
		local cmp_enabled = true
		vim.keymap.set("n", "<leader>ltc", function()
			cmp_enabled = not cmp_enabled
			cmp.setup({ enabled = cmp_enabled })
			vim.notify("Suggestions: " .. (cmp_enabled and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
		end, { noremap = true, silent = true, desc = "Toggle nvim-cmp suggestions" })

		--------------------------------------------------------------------------
		-- LSP Setup
		--------------------------------------------------------------------------
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		local on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }

			-- Use Conform for formatting (disable LSP formatting where appropriate)
			if client.name == "tsserver" or client.name == "pylsp" or client.name == "lua_ls" then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

			local function nmap(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
			end

			nmap("<leader>ld", vim.lsp.buf.hover, "Hover")
			nmap("<leader>lrn", vim.lsp.buf.rename, "Rename")
			nmap("<leader>lca", vim.lsp.buf.code_action, "Code Action")
			nmap("<leader>le", function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end, "Diagnostics Float")
			nmap("<leader>lgd", function()
				vim.lsp.buf_request(
					0,
					"textDocument/definition",
					vim.lsp.util.make_position_params(),
					function(_, result)
						if result and not vim.tbl_isempty(result) then
							vim.cmd("vsplit | wincmd l")
							vim.lsp.util.jump_to_location(result[1], "utf-8")
						else
							vim.notify("No definition found", vim.log.levels.INFO)
						end
					end
				)
			end, "Definition (vsplit)")
			nmap("<leader>lgi", function()
				require("telescope.builtin").lsp_implementations()
			end, "Implementations")
			nmap("<leader>lgr", function()
				require("telescope.builtin").lsp_references()
			end, "References")
		end

		--------------------------------------------------------------------------
		-- Plugin Setups
		--------------------------------------------------------------------------
		require("fidget").setup()
		require("mason").setup()

		require("mason-lspconfig").setup({
			automatic_installation = true,
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

				-- Custom LSP handlers
				zls = function()
					require("lspconfig").zls.setup({
						root_dir = require("lspconfig.util").root_pattern(".git", "build.zig", "zls.json"),
						settings = {
							zls = {
								enable_inlay_hints = true,
								enable_snippets = true,
								warn_style = true,
							},
						},
						on_attach = on_attach,
					})
					vim.g.zig_fmt_parse_errors = 0
					vim.g.zig_fmt_autosave = 0
				end,

				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,

				ltex = function()
					require("lspconfig").ltex.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							ltex = {
								checkFrequency = "save",
								language = "en-US",
								enabled = { "markdown", "text", "tex" },
								disabledRules = { ["en-US"] = { "WHITESPACE_RULE" } },
							},
						},
					})
				end,

				pylsp = function()
					require("lspconfig").pylsp.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							pylsp = {
								plugins = {
									pycodestyle = { enabled = false },
									pyflakes = { enabled = false },
									mccabe = { enabled = false },
									flake8 = { enabled = false },
									yapf = { enabled = false },
									autopep8 = { enabled = false },
									-- ruff = { enabled = true },
								},
							},
						},
					})
				end,
			},
		})
	end,
}
