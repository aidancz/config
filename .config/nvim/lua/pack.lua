--[[
official doc first:
:help vim.pack

how echasnovski uses:
https://github.com/echasnovski/nvim/blob/master/init.lua

use vim.pack with mini.deps
https://www.reddit.com/r/neovim/comments/1oo2wkr/comment/nn165a4/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

reset vim.pack:
https://github.com/neovim/neovim/issues/36520#issuecomment-3516470858
1. delete ~/.config/nvim/nvim-pack-lock.json
2. delete ~/.local/share/nvim/site/pack/core
3. restart nvim

local plugin does not support yet (2026-01-28):
https://github.com/neovim/neovim/issues/34765
https://github.com/nvim-mini/mini.nvim/issues/1326

hook (build):
https://github.com/neovim/neovim/issues/35493
https://github.com/neovim/neovim/pull/35360#issuecomment-3212327279

the `data` field of vim.pack.add has limitations yet (2026-01-28):
https://github.com/neovim/neovim/issues/36638

lazy loading:
https://github.com/neovim/neovim/issues/35303#issuecomment-3183308043
https://github.com/neovim/neovim/issues/35562

dependencies:
https://github.com/neovim/neovim/issues/34771#issuecomment-3043987557

packadd/packadd!
https://github.com/neovim/neovim/issues/35192
--]]

-- # allow hook via a custom `spec.data.on_packchanged`

vim.api.nvim_create_augroup("pack_config", {clear = true})
vim.api.nvim_create_autocmd(
	"PackChanged",
	{
		group = "pack_config",
		callback = function(ev)
			-- vim.print(ev)
--[[
vim.pack.add({
	"https://github.com/saghen/blink.cmp",
})
corresponding ev:
{
  buf = 1,
  data = {
    active = false,
    kind = "install",
    path = "/home/aidan/.local/share/nvim/site/pack/core/opt/blink.cmp",
    spec = {
      name = "blink.cmp",
      src = "https://github.com/saghen/blink.cmp"
    }
  },
  event = "PackChanged",
  file = "/home/aidan/.local/share/nvim/site/pack/core/opt/blink.cmp",
  group = 9,
  id = 13,
  match = "/home/aidan/.local/share/nvim/site/pack/core/opt/blink.cmp"
}

vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		data = {
			on_packchanged = function(ev)
			end,
		},
	},
})
corresponding ev:
{
  buf = 1,
  data = {
    active = false,
    kind = "install",
    path = "/home/aidan/.local/share/nvim/site/pack/core/opt/blink.cmp",
    spec = {
      data = {
        on_packchanged = <function 1>
      },
      name = "blink.cmp",
      src = "https://github.com/saghen/blink.cmp"
    }
  },
  event = "PackChanged",
  file = "/home/aidan/.local/share/nvim/site/pack/core/opt/blink.cmp",
  group = 9,
  id = 13,
  match = "/home/aidan/.local/share/nvim/site/pack/core/opt/blink.cmp"
}
--]]
			local data = ev.data.spec.data or {}
			local on_packchanged = data.on_packchanged
			if on_packchanged == nil then return end
			on_packchanged(ev)
		end,
	}
)
