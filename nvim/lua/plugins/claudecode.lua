---@diagnostic disable: missing-fields

return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	lazy = false,
	config = function()
		require("claudecode").setup({
			-- Selection Tracking
			track_selection = true,
			visual_demotion_delay_ms = 50,

			-- Terminal Configuration
			terminal = {
				split_side = "right", -- "left" or "right"
				split_width_percentage = 0.4,
				auto_close = true,
				provider = "none",
				-- provider = "snacks",
				snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()` - see Floating Window section below
			},

			-- Diff Integration
			diff_opts = {
				layout = "horizontal", -- "vertical" or "horizontal"
				open_in_new_tab = true,
				keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
				hide_terminal_in_new_tab = false,
				-- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"
			},
		})

		-- { "<leader>a", nil, desc = "AI/Claude Code" },
		-- { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		-- { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		-- { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		-- { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
		vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
		vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
		vim.keymap.set("v", "<leader>>", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			callback = function(ev)
				vim.keymap.set("n", "<leader>>", "<cmd>ClaudeCodeTreeAdd<cr>", { desc = "Add file", buffer = ev.buf })
			end,
		})
		vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
		vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })
	end,
}
