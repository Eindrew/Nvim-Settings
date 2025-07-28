return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	config = function()
		require("lsp_signature").setup({
			floating_window = true,
			hint_enable = true,
			hint_prefix = "",
			handler_opts = {
				border = "rounded",
			},
			always_trigger = true,
		})
	end,
}
