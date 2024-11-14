--[[
debug:
if true then return end
vim.api.nvim_out_write(vim.fn.system({"date", "--iso-8601=ns"}))
--]]

vim.loader.enable()

----------------------------------------------------------------

require("builtin-plugin")

require("option")

require("keymap")
require("paragraph-motion")
require("empty-line-and-char")
require("xX-delete-single-char")

require("autocmd")
require("eol-extmark-at-cursor-line")

----------------------------------------------------------------

lazyspec =
{

require("lazy-spec/nofrils"),
-- require("lazy-spec/tokyonight"),
require("lazy-spec/nvim-treesitter"),

require("lazy-spec/sentiment"),
-- require("lazy-spec/indent-blankline"),
require("lazy-spec/vim-mark"),
require("lazy-spec/nvim-colorizer"),
-- require("lazy-spec/gitsigns"),

require("lazy-spec/marks"),

-- require("lazy-spec/nvim-ufo"),

-- require("lazy-spec/undotree-mbbill"),
require("lazy-spec/undotree-jiaoshijie"),

-- require("lazy-spec/vim-ReplaceWithRegister"),
-- require("lazy-spec/nvim-surround"),
require("lazy-spec/Comment"),
require("lazy-spec/mini"),

-- require("lazy-spec/LuaSnip"),

require("lazy-spec/nvim-cmp"),

-- require("lazy-spec/vim-suda"),
require("lazy-spec/fcitx"),



-- require("lazy-spec/nvim-lspconfig"),

-- require("lazy-spec/outline"),
require("lazy-spec/aerial"),

-- require("lazy-spec/sniprun"),

require("lazy-spec/markdown-preview"),
require("lazy-spec/vim-table-mode"),



require("lazy-spec/telescope"),
require("lazy-spec/fzf-lua"),
require("lazy-spec/yazi"),

}

require("lazy-setup")

----------------------------------------------------------------

vim.cmd([[
]])
