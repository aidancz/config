vim.pack.add({
	{
		src = "https://github.com/kevinhwang91/nvim-fundo",
		data = {
			on_packchanged = function(ev)
				local kind = ev.data.kind
				local kinds = {"install", "update"}
				if not vim.list_contains(kinds, kind) then return end
				local active = ev.data.active
				if not active then
					vim.cmd.packadd("nvim-fundo")
				end
				require("fundo").install()
			end,
		},
	},
	"https://github.com/kevinhwang91/promise-async",
})

vim.o.undofile = true
require("fundo").setup()
