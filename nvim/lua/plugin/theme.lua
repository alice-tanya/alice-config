-- 主题

local setup = function()
  vim.cmd [[colorscheme tokyonight-night ]]
end

return {
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = setup, opt=..., enable = false },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = setup, enable = true },
}

