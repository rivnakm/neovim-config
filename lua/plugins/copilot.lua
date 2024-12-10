-- GitHub Copilot
return {
	"zbirenbaum/copilot.lua",
	lazy = true,
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<C-c>a",
					dismiss = "<C-c>d",
				},
			},
		})
	end,
}
