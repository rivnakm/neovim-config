-- AI agent chat via Agent Client Protocol (ACP)
return {
	"carlos-algms/agentic.nvim",
	opts = {
		provider = "opencode-acp",
	},
	keys = {
		{
			"<leader>at",
			function()
				require("agentic").toggle()
			end,
			desc = "[A]gentic [T]oggle chat",
		},
		{
			"<leader>ac",
			function()
				require("agentic").add_selection_or_file_to_context()
			end,
			desc = "[A]gentic add to [C]ontext",
		},
		{
			"<leader>an",
			function()
				require("agentic").new_session()
			end,
			desc = "[A]gentic [N]ew session",
		},
	},
}
