return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "InsertEnter",
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 75,
			keymap = {
				accept = "<Tab>",
				accept_word = "<C-w>",
				accept_line = "<C-l>",
				next = "<C-n>",
				prev = "<C-p>",
				dismiss = "<C-]>",
			},
			layout = {
				align = "top",
				wrap = true,
			},
		},
		panel = {
			enabled = false,
		},
	},
}
