return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			blue = "#0091FF",
			green = "#31D251",
			violet = "#CB6EFA",
			yellow = "#FFB820",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",

			red1 = "#FF0000",
			offred = "#DC1B1B",
			lightred = "#FF2F2F",
			darkred = "#A81E1E",
			nightred = "#4A0808",

			offwhite = "#E0E0E0",
			lightgray = "#666666",
			gray = "#444444",
			deepgray = "#333333",
			darkgray = "#402020",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.lightred, fg = colors.darkgray, gui = "bold" },
				b = { bg = colors.deepgray, fg = colors.fg },
				c = { bg = colors.deepgray, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.deepgray, fg = colors.fg },
				c = { bg = colors.deepgray, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.deepgray, fg = colors.fg },
				c = { bg = colors.deepgray, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.deepgray, fg = colors.fg },
				c = { bg = colors.deepgray, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.deepgray, fg = colors.fg },
				c = { bg = colors.deepgray, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.darkgray, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.darkgray, fg = colors.semilightgray },
				c = { bg = colors.darkgray, fg = colors.semilightgray },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
