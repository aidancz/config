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
			files = {
				cwd = require("fzf-lua/path").git_root(nil, true)
				-- https://github.com/ibhagwan/fzf-lua/issues/140
			}
		})



		vim.keymap.set("n", "f", require("fzf-lua").builtin)



		vim.api.nvim_set_hl(0, "FzfLuaNormal",            {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaBorder",            {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaTitle",             {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaBackdrop",          {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal",     {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder",     {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaPreviewTitle",      {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaCursor",            {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaCursorLine",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaCursorLineNr",      {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaSearch",            {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaScrollBorderEmpty", {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaScrollBorderFull",  {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaScrollFloatEmpty",  {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaScrollFloatFull",   {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaHelpNormal",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaHelpBorder",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaHeaderBind",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaHeaderText",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaPathColNr",         {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaPathLineNr",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaBufName",           {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaBufNr",             {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaBufFlagCur",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaBufFlagAlt",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaTabTitle",          {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaTabMarker",         {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaDirIcon",           {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaDirPart",           {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFilePart",          {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaLiveSym",           {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfNormal",         {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfCursorLine",     {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfMatch",          {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfBorder",         {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfScrollbar",      {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfSeparator",      {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfGutter",         {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfHeader",         {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfInfo",           {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfPointer",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfMarker",         {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfSpinner",        {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfPrompt",         {link = "nofrils-default"})
		vim.api.nvim_set_hl(0, "FzfLuaFzfQuery",          {link = "nofrils-default"})

	end,
}
