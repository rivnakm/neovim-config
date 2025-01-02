-- Automatically close buffers after X minutes of inactivity
return {
	"chrisgrieser/nvim-early-retirement",
	event = "VeryLazy",
	opts = {
		deleteBufferWhenFileDeleted = false,
	},
}
