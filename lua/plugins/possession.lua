-- Session manager
return {
	"jedrzejboczar/possession.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("possession").setup({
			hooks = {
				-- before_save = function()
				-- 	local windows = vim.api.nvim_list_wins()
				-- 	for _, win in ipairs(windows) do
				-- 		local buf = vim.api.nvim_win_get_buf(win)
				-- 		if string.find(vim.api.nvim_buf_get_name(buf), "toggleterm") ~= nil then
				-- 			vim.api.nvim_win_close(win, true)
				-- 		end
				-- 	end
				--
				-- 	return {}
				-- end,
				before_load = function()
					local bufs = vim.api.nvim_list_bufs()
					for _, buf in ipairs(bufs) do
						if string.find(vim.api.nvim_buf_get_name(buf), "toggleterm") ~= nil then
							vim.api.nvim_buf_delete(buf, { force = true })
						end
					end

					return {}
				end,
			},
		})
		require("telescope").load_extension("possession")
		local save_session = function()
			local session_name = require("possession.session").session_name or vim.fn.input("Session name: ")
			if session_name ~= "" then
				require("possession.session").save(session_name)
			end
		end
		local delete_session = function()
			local session_name = require("possession.session").session_name or ""
			if session_name ~= "" then
				require("possession.session").delete(session_name)
			end
		end

		vim.keymap.set(
			"n",
			"<leader>ss",
			require("telescope").extensions.possession.list,
			{ desc = "[S]earch [S]essions" }
		)
		vim.keymap.set("n", "<leader>od", delete_session, { desc = "P[o]ssession [D]elete" })
		vim.keymap.set("n", "<leader>os", save_session, { desc = "P[o]ssession [S]ave" })
	end,
}
