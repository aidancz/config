local M = {}

-- function M:peek()
-- 	local output_string = Command("cat"):args({"", tostring(self.file.url)}):stdout(Command.PIPED):output().stdout
-- 	local output_string_expand = output_string:gsub("\t", string.rep(" ", PREVIEW.tab_size))
-- 	local p = ui.Paragraph.parse(self.area, output_string_expand)
-- 	ya.preview_widgets(self, {p:wrap(ui.Paragraph.WRAP)})
-- end

function M:peek()
	local lines
	local child

	lines = Command("cat"):args({"", tostring(self.file.url)}):stdout(Command.PIPED):output().stdout

	child = Command("expand"):stdin(Command.PIPED):stdout(Command.PIPED):spawn()
	child:write_all(lines)
	child:flush()
	lines = child:wait_with_output().stdout

	ya.preview_widgets(self, {ui.Paragraph.parse(self.area, lines)})
end

function M:seek() end

return M
