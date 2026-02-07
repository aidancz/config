local map = function(lhs, operatorfunc)
	vim.keymap.set(
		{"n", "x"},
		lhs,
		function()
			vim.o.operatorfunc = operatorfunc
			return "g@"
		end,
		{
			expr = true,
		}
	)
end

map("<space>i", [[v:lua.require'operator'.inspect]])
map("<space>v", [[v:lua.require'operator'.hl.tog]])
map("<space>m", [[v:lua.require'operator'.hls.tog]])
map("<space>t", [[v:lua.require'operator'.comment_multiply]])
