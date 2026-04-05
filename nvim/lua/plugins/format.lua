return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format()
			end,
			desc = "Format file",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			javascriptreact = { "prettier" },
			go = { "goimports", "gofumpt" },
			rust = { "rustfmt" },
			zig = { "zigfmt" },
			bash = { "shfmt" },
			sh = { "shfmt" },
			markdown = { "prettier" },
			r = { "r_styler" },
			java = { "google-java-format" },
			tex = { "latexindent" },
			latex = { "latexindent" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters = {
			ruff_format = {
				command = "ruff",
				args = { "format", "--stdin-filename", "$FILENAME", "-" },
				stdin = true,
			},
			prettier = { prepend_args = { "--tab-width", "2", "--use-tabs", "false" } },
			stylua = { prepend_args = { "--indent-width", "4" } },
			shfmt = { prepend_args = { "-i", "4" } },
			r_styler = {
				command = "Rscript",
				args = {
					"-e",
					"styler::style_file(commandArgs(trailingOnly = TRUE)[1])",
					"$FILENAME",
				},
				stdin = false,
			},
		},
	},
}
