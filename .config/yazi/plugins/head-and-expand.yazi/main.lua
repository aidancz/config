local M = {}

M.peek = function(self, job)
	local a1 = Command("head")
	a1.args(a1, {"-n 128", tostring(job.file.url)})
	a1.stdout(a1, Command.PIPED)

	local a1_output, a1_err = a1.output(a1)
	local a1_output_stdout = a1_output.stdout

	local a2 = Command("expand")
	a2.stdin(a2, Command.PIPED)
	a2.stdout(a2, Command.PIPED)

	local a2_child = a2.spawn(a2)
	a2_child.write_all(a2_child, a1_output_stdout)
	a2_child.flush(a2_child)

	local a2_output, a2_err = a2_child.wait_with_output(a2_child)
	local a2_output_stdout = a2_output.stdout

	local b = ui.Text(a2_output_stdout)
	b.area(b, job.area)
	b.wrap(b, ui.Text.WRAP)

	ya.preview_widgets(job, {b})
end

M.seek = function(self, job)
end

return M
