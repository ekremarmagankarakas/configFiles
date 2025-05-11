local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Add the #f snippet as an autosnippet for all filetypes
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

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*", -- latest major version
	build = "make install_jsregexp",
}
