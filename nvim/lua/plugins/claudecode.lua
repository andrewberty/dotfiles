return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		-- Selection Tracking
		track_selection = true,
		visual_demotion_delay_ms = 50,

		-- Terminal Configuration
		terminal = {
			split_side = "right", -- "left" or "right"
			split_width_percentage = 0.4,
			auto_close = true,
			snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()` - see Floating Window section below
		},

		-- Diff Integration
		diff_opts = {
			layout = "vertical", -- "vertical" or "horizontal"
			open_in_new_tab = false,
			keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
			hide_terminal_in_new_tab = false,
			-- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"
		},
	},
	keys = {
		-- { "<leader>a", nil, desc = "AI/Claude Code" },
		-- { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		-- { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		-- { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		-- { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },

		{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>>", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		{
			"<leader>>",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
		},
		-- Diff management
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
}
