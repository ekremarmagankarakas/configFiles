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
			zigfmt = {
				command = "zig",
				args = { "fmt", "--stdin" },
				stdin = true,
			},
			shfmt = {
				prepend_args = { "-i", "4" },
			},
			["google-java-format"] = {
				command = "google-java-format",
				args = { "-" },
				stdin = true,
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
	},
}
