-- Debug Adapter Protocol UI
return {
	"igorlfs/nvim-dap-view",
	dependencies = { "mfussenegger/nvim-dap" },
	opts = {
		-- Auto open when a session starts, auto close when it finishes
		auto_toggle = true,
	},
}
