-- # * (all languages)

vim.lsp.config["*"] = {
	root_markers = {
		".git",
	},
}

-- # lua

vim.lsp.config["lua"] = {
	cmd = {
		"lua-language-server",
	},
	filetypes = {
		"lua",
	},
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
}
vim.lsp.enable("lua")
-- https://www.reddit.com/r/neovim/comments/1gtfoqt/hey_anyone_got_a_clue_what_my_diagnostics_signs/
-- https://github.com/LuaLS/lua-language-server/issues/2961
