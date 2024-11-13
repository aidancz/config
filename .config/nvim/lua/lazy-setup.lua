-- https://lazy.folke.io/installation
-- https://lazy.folke.io/configuration
-- https://github.com/LazyVim/LazyVim/discussions/1483

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = lazyspec,
	dev = {
		path = "~/sync_git",
	},
	lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})
