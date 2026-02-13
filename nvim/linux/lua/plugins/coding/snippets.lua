return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

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
	end,
}
