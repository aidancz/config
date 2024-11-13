return
{
	"ibhagwan/fzf-lua",
	config = function()
		require("fzf-lua").setup({
			keymap = {
				builtin = {
				},
				fzf = {
					["f12"] = "abort",
				},
			},
		})
	end,
}
