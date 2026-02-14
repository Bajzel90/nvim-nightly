vim.pack.add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
	-- Enable for markdown files
	file_types = { "markdown" },

	code = {
		width = "block",
		right_pad = 1,
		conceal_delimiters = false,
		border = "none",
	},
	heading = {
		sign = false,
		icons = {},
	},
	bullet = { enabled = true, icons = { "", "" } },
	render_modes = { "n", "c", "t" },
})
