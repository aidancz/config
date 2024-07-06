local M = {}

function M:peek()
	local output_string = Command("cat"):args({ "", tostring(self.file.url) }):stdout(Command.PIPED):output().stdout
	local output_string_expand = output_string:gsub("\t", string.rep(" ", PREVIEW.tab_size))

	local p = ui.Paragraph.parse(self.area, output_string_expand)

	ya.preview_widgets(self, { p:wrap(ui.Paragraph.WRAP) })
end

function M:seek() end

return M
