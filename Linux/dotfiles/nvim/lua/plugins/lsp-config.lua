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
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "autopep8" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },
			},
			formatters = {
				autopep8 = { prepend_args = { "--indent-size", "2" } },
				prettier = { prepend_args = { "--tab-width", "2", "--use-tabs", "false" } },
				stylua = { prepend_args = { "--indent-width", "2" } },
			},
			default_formatter = "prettier",
			log_level = vim.log.levels.DEBUG,
		})

		-- Auto-format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				require("conform").format()
			end,
		})

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
		local capabilities =
			vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

		local on_attach = function(_, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }

			-- Keymaps
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>le", function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end, opts)

			-- Definitions and Implementations in split
			-- Go to definition (gd) in vsplit
			vim.keymap.set("n", "<leader>lgd", function()
				vim.lsp.buf_request(
					0,
					"textDocument/definition",
					vim.lsp.util.make_position_params(),
					function(err, result, ctx, config)
						if result and not vim.tbl_isempty(result) then
							vim.cmd("vsplit")
							vim.cmd("wincmd l")
							vim.lsp.util.jump_to_location(result[1], "utf-8")
						else
							vim.notify("No definition found", vim.log.levels.INFO)
						end
					end
				)
			end, opts)

			-- Go to implementation (gi) in vsplit
			vim.keymap.set("n", "<leader>lgi", function()
				vim.lsp.buf_request(
					0,
					"textDocument/implementation",
					vim.lsp.util.make_position_params(),
					function(err, result, ctx, config)
						if result and not vim.tbl_isempty(result) then
							vim.cmd("vsplit")
							vim.cmd("wincmd l")
							vim.lsp.util.jump_to_location(result[1], "utf-8")
						else
							vim.notify("No implementation found", vim.log.levels.INFO)
						end
					end
				)
			end, opts)
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
									pycodestyle = {
										ignore = { "E501", "E126", "E712" },
										maxLineLength = 999,
										indentSize = 2,
									},
									flake8 = {
										ignore = { "E501" },
										maxLineLength = 999,
									},
								},
							},
						},
					})
				end,
			},
		})
	end,
}
