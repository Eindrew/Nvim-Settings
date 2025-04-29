-- ~/.config/nvim/ftdetect/tex.lua
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.tex", -- Match all files ending in .tex
	desc = "Set filetype to tex for .tex files",
	command = "set filetype=tex", -- Force the filetype to 'tex'
})
