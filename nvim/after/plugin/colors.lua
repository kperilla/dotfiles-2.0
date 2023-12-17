function ColorMyPencils(color)
	color = color or "kanagawa"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "#1b1421" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1b1421" })
end

ColorMyPencils()
