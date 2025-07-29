return {
	"folke/tokyonight.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local bg = "#1D1D1D"
		local bg_dark = "#111111"
		local bg_highlight = "#333333"
		local bg_search = "#DB2929"
		local bg_visual = "#444444"
		local fg = "#FFFFFF"
		local fg_dark = "#E0E0E0"
		local fg_gutter = "#708090"
		local border = "#B0B0B0"
		--[[

    local bg = "#011628"
    local bg_dark = "#011423"
		local bg_highlight = "#143652"
		local bg_search = "#0A64AC"
		local bg_visual = "#275378"
		local fg = "#CBE0F0"
		local fg_dark = "#B4D0E9"
		local fg_gutter = "#627E97"
		local border = "#547998"
    ]]

		require("tokyonight").setup({
			style = "night",
			on_colors = function(colors)
				colors.bg = bg
				colors.bg_dark = bg_dark
				colors.bg_float = bg_dark
				colors.bg_highlight = bg_highlight
				colors.bg_popup = bg_dark
				colors.bg_search = bg_search
				colors.bg_sidebar = bg_dark
				colors.bg_statusline = bg_dark
				colors.bg_visual = bg_visual
				colors.border = border
				colors.fg = fg
				colors.fg_dark = fg_dark
				colors.fg_float = fg
				colors.fg_gutter = fg_gutter
				colors.fg_sidebar = fg_dark
			end,

			on_highlights = function(hl, color)
				hl["AlphaButtons"] = { fg = "#FF6F6F" }
				hl["AlphaHeader"] = { fg = "#DC1B1B" }
				hl["AlphaHeaderLabel"] = { fg = "#ff9e64" }

				hl.SignColumn = {
					bg = bg,
					fg = "#DC1B1B",
				}

				hl.GitSignsAdd = { fg = "#DC1B1B", bg = bg }
				hl.GitSignsChange = { fg = "#DC1B1B", bg = bg }
				hl.GitSignsDelete = { fg = "#DC1B1B", bg = bg }

				hl["@keyword"] = { fg = "#DC1B1B", bold = false }
				hl["@keyword.import"] = { fg = "#DC1B1B", bold = false }
				hl["@keyword.function"] = { fg = "#DC1B1B", bold = false }
				hl["@module"] = { fg = "#FF6F6F", bold = false }
				hl["@attribute"] = { fg = "#FF5330", bold = false }
				hl["@type"] = { fg = "#FF8940", bold = false }
				hl["@type.builtin"] = { fg = "#75CEFF", bold = false }
				hl["@variable.member"] = { fg = "#0091FF", bold = false }
				hl["Constant"] = { fg = "#8B6FFA", bold = false }
				hl["Special"] = { fg = "#8B6FFA", bold = false }
				hl["@operator"] = { fg = "#DC1B1B", bold = true }
				hl["@function"] = { fg = "#FF6F6F", bold = false }
				hl["Function"] = { fg = "#FF6F6F", bold = false }
				hl["@variable"] = { fg = "#E0E0E0", bold = false }
				hl["@variable.builtin"] = { fg = "#0091FF", bold = false }
				hl["@variable.parameter"] = { fg = "#0091FF", bold = false }
				hl["String"] = { fg = "#FFA013", bold = false }
				hl["@string.documentation"] = { fg = "#FFA013", bold = false }
				hl["Statement"] = { fg = "#DC1B1B", bold = false }
				hl["@property"] = { fg = "#FF6F6F", bold = false }

				hl.AlphaHeader = {
					fg = "#FFFFFF",
					bold = true,
				}

				hl.AlphaButtons = {
					fg = "#FFFFFF",
				}

				hl.AlphaFooter = {
					fg = "#FFFFFF",
					italic = true,
				}
			end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
