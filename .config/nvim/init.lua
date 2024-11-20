--[[

debug:

do return end
os.exit()
https://stackoverflow.com/questions/20188458/how-to-exit-a-lua-scripts-execution

vim.api.nvim_out_write(vim.fn.system({"date", "--iso-8601=ns"}))

--]]

vim.loader.enable()

----------------------------------------------------------------

require("plugin-builtin")

require("option")

require("keymap")
require("tT")
require("lfsp")
require("xX")

require("autocmd")
require("eolmark")

----------------------------------------------------------------

lazyspec =
{

require("lazy-spec/nofrils"),
-- require("lazy-spec/xresources-nvim"),
-- require("lazy-spec/nvim-xresources"),
-- require("lazy-spec/tokyonight"),

require("lazy-spec/nvim-treesitter"),

require("lazy-spec/sentiment"),
-- require("lazy-spec/indent-blankline"),
require("lazy-spec/vim-mark"),
require("lazy-spec/nvim-colorizer"),
-- require("lazy-spec/gitsigns"),



require("lazy-spec/paramo"),
-- require("lazy-spec/nvim-better-n"),
-- require("lazy-spec/nvim-next"),
-- https://www.reddit.com/r/neovim/comments/1fltduc/better_mappings_for_the_n_and_p_keys/

-- require("lazy-spec/undotree-mbbill"),
require("lazy-spec/undotree-jiaoshijie"),

require("lazy-spec/marks"),

-- require("lazy-spec/nvim-ufo"),

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

require("redir")

----------------------------------------------------------------

vim.cmd([[
]])
