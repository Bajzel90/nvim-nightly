vim.pack.add({
	"https://codeberg.org/mfussenegger/nvim-dap.git",
	"https://github.com/igorlfs/nvim-dap-view",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/mfussenegger/nvim-dap-python",
})

-- Configuration after loading
local dap = require("dap")
require("dap-view").setup({
	windows = {
		size = 0.45,
		position = "right",
		terminal = {
			size = 0.5,
			position = "below",
			-- List of debug adapters for which the terminal should be ALWAYS hidden
			hide = {},
		},
	},
})

vim.g.dap_virtual_text_debug = true

require("nvim-dap-virtual-text").setup({
	enabled = true,
	all_frames = true,
	-- highlight_changed_variables = true,
	-- highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false, -- bez komentarza, żeby było czytelne
	virt_text_pos = "eol", -- klasyczne na końcu linii
	-- display_callback = function(variable, _, _, _)
	-- 	return variable.name .. " = " .. variable.value
	-- end,
})

vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#e2ff29", bg = "#3a506b" })
vim.api.nvim_set_hl(0, "NvimDapVirtualTextError", { fg = "#ff0000", bg = "#3a506b" })

  -- stylua: ignore start
local keys = {
    { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() dap.continue() end, desc = "Run/Continue" },
    { "<leader>da", function() dap.continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() dap.run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() dap.goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>dl", function() dap.step_into() end, desc = "Step Into" },
    { "<leader>dd", function() dap.down() end, desc = "Down" },
    { "<leader>du", function() dap.up() end, desc = "Up" },
    { "<leader>dh", function() dap.step_out() end, desc = "Step Out" },
    { "<leader>dj", function() dap.step_over() end, desc = "Step Over" },
    { "<leader>dr", function() dap.repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() dap.session() end, desc = "Session" },
    { "<leader>dt", function() dap.terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
}
-- stylua: ignore end

for _, map in ipairs(keys) do
	local opts = { desc = map.desc }
	if map.silent ~= nil then
		opts.silent = map.silent
	end
	if map.noremap ~= nil then
		opts.noremap = map.noremap
	else
		opts.noremap = true
	end
	if map.expr ~= nil then
		opts.expr = map.expr
	end

	local mode = map.mode or "n"
	vim.keymap.set(mode, map[1], map[2], opts)
end

require("dap-python").setup("uv")
