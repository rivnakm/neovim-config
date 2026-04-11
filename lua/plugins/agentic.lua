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
			mode = { "n", "v", "i" },
			desc = "[A]gentic [T]oggle chat",
		},
		{
			"<leader>ac",
			function()
				require("agentic").add_selection_or_file_to_context()
			end,
			mode = { "n", "v" },
			desc = "[A]gentic add to [C]ontext",
		},
		{
			"<leader>an",
			function()
				require("agentic").new_session()
			end,
			mode = { "n", "v", "i" },
			desc = "[A]gentic [N]ew session",
		},
	},
}
