function ColorMyPencils(color)
    -- Colors:
    -- kanagawa
    -- catppuccin-mocha
    color = color or "catppuccin-mocha"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "#1b1421" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1b2421" })
end

ColorMyPencils()
