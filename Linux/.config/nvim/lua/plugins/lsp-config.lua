return {
	"neovim/nvim-lspconfig",
	version = "*",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", commit = "1a31f824b9cd5bc6f342fc29e9a53b60d74af245" },
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"l3mon4d3/luasnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},
	config = function()
		-- Conform setup for formatting
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },
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
		vim.keymap.set("n", "<leader>gf", function()
			require("conform").format()
		end, { noremap = true, silent = true, desc = "Format file" })

		-- Autocompletion setup
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		-- LSP keymaps (only when LSP attaches)
		local on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }
			-- Hover documentation
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

			-- Go to definition (gd) in vsplit
			vim.keymap.set("n", "gd", function()
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
			vim.keymap.set("n", "gi", function()
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

			-- Rename symbol
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			-- Code actions
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

			-- Open diagnostics in a floating window
			vim.keymap.set("n", "<leader>e", function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end, { noremap = true, silent = true, buffer = bufnr })
		end

		-- Completion behavior
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
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

		-- Diagnostic settings
		vim.diagnostic.config({
			virtual_text = false, -- no typing errors next to code
			underline = true, -- underline errors
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Other setups
		require("fidget").setup({})
		require("mason").setup()

		-- Mason LSPConfig handlers
		require("mason-lspconfig").setup({
			automatic_installation = true,
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

				-- Special setup for Zig LSP
				zls = function()
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
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

				-- Special setup for Lua LSP
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
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
			},
		})
	end,
}
