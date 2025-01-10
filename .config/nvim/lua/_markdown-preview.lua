require("mini.deps").add({
	source = "iamcco/markdown-preview.nvim",
	hooks = {
		post_install = function()
			require("mini.deps").later(function()
			vim.fn["mkdp#util#install"]()
			end)
		end,
		post_checkout = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
})

vim.g.mkdp_auto_start = false
vim.g.mkdp_auto_close = true
vim.g.mkdp_refresh_slow = false
vim.g.mkdp_command_for_global = false
vim.g.mkdp_open_to_the_world = false
vim.g.mkdp_open_ip = ""
vim.g.mkdp_browser = ""
vim.g.mkdp_echo_preview_url = false
-- function open_browser(url)
-- 	vim.cmd("silent !firefox --new-window" .. " " .. url)
-- end
vim.cmd([[
function OpenBrowser(url)
	silent execute "!firefox --new-window" . " " . a:url
endfunction
]])
vim.g.mkdp_browserfunc = "OpenBrowser"
vim.g.mkdp_preview_options = {
	mkit = {breaks = true},
	katex = {},
	uml = {},
	maid = {},
	disable_sync_scroll = false,
	sync_scroll_type = "middle",
	hide_yaml_meta = true,
	sequence_diagrams = {},
	flowchart_diagrams = {},
	content_editable = false,
	disable_filename = true,
}
vim.g.mkdp_markdown_css = ""
vim.g.mkdp_highlight_css = ""
vim.g.mkdp_port = ""
vim.g.mkdp_page_title = "${name}"
vim.g.mkdp_filetypes = {"markdown", "text"}
