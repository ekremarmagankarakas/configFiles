return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local ls = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		----------------------------------------------------------------------
		-- Snippet navigation
		----------------------------------------------------------------------
		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true, desc = "LuaSnip: expand/jump" })

		vim.keymap.set({ "i", "s" }, "<C-k>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true, desc = "LuaSnip: jump back" })

		----------------------------------------------------------------------
		-- Global snippets (all filetypes)
		----------------------------------------------------------------------
		ls.add_snippets("all", {
			s("#f", {
				t("#files:`**/*."),
				i(1),
				t("`"),
			}),
		})

		ls.add_snippets("all", {
			s("#fd", {
				t({
					"#files:`**/*.py`",
					"#files:`**/*.js`",
					"#files:`**/*.jsx`",
					"#files:`**/*.html`",
					"#files:`**/*.css`",
				}),
			}),
		})

		----------------------------------------------------------------------
		-- Python snippets
		----------------------------------------------------------------------
		ls.add_snippets("python", {

			-- try / except
			s("try", {
				t({ "try:", "\t" }),
				i(1, "pass"),
				t({ "", "except Exception as e:", "\t" }),
				i(2, "print(e)"),
			}),

			-- assert
			s("assert", {
				t('assert expected == actual, f"\\nActual\\n{actual}\\nExpected\\n{expected}"'),
			}),

			-- def (cursor ends at function name)
			s("def", {
				t("def "),
				i(3, "function_name"),
				t("("),
				i(2),
				t({ "):", "\t" }),
				i(1, "pass"),
			}),

			-- class with __init__
			s("class", {
				t("class "),
				i(2, "ClassName"),
				t({ ":", "\tdef __init__(self" }),
				i(3),
				t({ "):", "\t\t" }),
				i(1, "pass"),
			}),

			-- if __name__ == "__main__"
			s("main", {
				t({ 'if __name__ == "__main__":', "\t" }),
				i(1, "main()"),
			}),

			-- for loop (cursor ends at iterable)
			s("for", {
				t("for "),
				i(2, "item"),
				t(" in "),
				i(3, "iterable"),
				t({ ":", "\t" }),
				i(1, "pass"),
			}),

			-- while loop (cursor ends at condition)
			s("while", {
				t("while "),
				i(2, "condition"),
				t({ ":", "\t" }),
				i(1, "pass"),
			}),

			-- with open (cursor ends at filename)
			s("with", {
				t("with open("),
				i(4, '"file.txt"'),
				t(", "),
				i(3, '"r"'),
				t(") as "),
				i(2, "f"),
				t({ ":", "\t" }),
				i(1, "pass"),
			}),

			------------------------------------------------------------------
			-- Docstrings
			------------------------------------------------------------------

			-- Function docstring
			s("doc", {
				t({ '"""', "" }),
				t("\t"),
				i(1, "Summary of the function."),
				t({ "", "", "\tArgs:", "\t\t" }),
				i(2, "param (type): description"),
				t({ "", "", "\tReturns:", "\t\t" }),
				i(3, "type: description"),
				t({ "", '"""' }),
			}),

			-- Class docstring
			s("docc", {
				t({ '"""', "" }),
				t("\t"),
				i(1, "Summary of the class."),
				t({ "", "", "\tAttributes:", "\t\t" }),
				i(2, "attr (type): description"),
				t({ "", '"""' }),
			}),

			-- __init__ docstring
			s("doci", {
				t({ '"""', "" }),
				t("\t"),
				i(1, "Initialize the object."),
				t({ "", "", "\tArgs:", "\t\t" }),
				i(2, "param (type): description"),
				t({ "", '"""' }),
			}),

			-- Module docstring
			s("docm", {
				t({ '"""', "" }),
				i(1, "Module description."),
				t({ "", "", "Usage:", "\tpython " }),
				i(2, "script.py"),
				t({ "", '"""', "" }),
			}),
		})
	end,
}
