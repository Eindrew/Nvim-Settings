-- ~/.config/nvim/snippets/tex.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt -- For easier formatting

return {
	s(
		"documentclass", -- Trigger for the snippet
		{
			-- Document Class Setup
			t("\\documentclass["),
			-- Placeholder 1: Optional arguments like font size (e.g., 11pt, 12pt)
			i(1),
			t("]{"),
			-- Placeholder 2: Document class (article, report, book, etc.)
			i(2, "article"),
			t({ "}", "" }), -- End class, add empty line

			-- Common Packages (add/remove as needed)
			t({ "\\usepackage[utf8]{inputenc} % Input encoding (for pdflatex)", "" }),
			t({ "\\usepackage[T1]{fontenc}    % Font encoding (for pdflatex)", "" }),
			t({ "\\usepackage{amsmath}        % Math formulas", "" }),
			t({ "\\usepackage{amssymb}        % Math symbols", "" }),
			t({ "\\usepackage{graphicx}       % Include images", "" }),
			t({ "\\usepackage[" }),
			-- Placeholder 3: Geometry options (e.g., margin=1in)
			i(3, "margin=1in"),
			t({ "]{geometry}      % Page layout" }),
			t({ "\\usepackage{hyperref}       % Clickable links and PDF metadata (usually load last)" }),
			t({ "", "" }), -- Add empty lines

			-- Title, Author, Date
			t("\\title{"),
			i(4, "Document Title"),
			t({ "}", "" }),
			t("\\author{"),
			i(5, "Your Name"),
			t({ "}", "" }),
			t("\\date{"),
			i(6, "\\today"),
			t({ "}", "" }), -- Default to today's date
			t({ "", "" }), -- Add empty lines

			-- Document Environment
			t({ "\\begin{document}", "" }),
			-- Placeholder 0: Final cursor position after section
			i(0),
			t({ "", "" }),
			t({ "\\end{document}" }),
		},
		{
			-- Snippet options
			descr = "Setup basic LaTeX document structure",
		}
	),

	-- Add more LaTeX snippets here if you wish...
}
