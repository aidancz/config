-- # xrdb (x server resource database utility)

-- https://github.com/nekonako/xresources-nvim/blob/master/lua/xresources.lua
-- https://github.com/martineausimon/nvim-xresources/blob/main/lua/nvim-xresources/system.lua

local M = {}

M.get_xrdb_query = function()
	local str = io.popen("xrdb -query", "r"):read("*a")
	local lis = vim.split(str, "\n", {trimempty = true})
	local tbl = {}
	for _, i in ipairs(lis) do
		local kv = vim.split(i, ":\t")
		local k = kv[1]
		local v = kv[2]
		tbl[k] = v
	end
	return tbl
end

M.color = {
	"color0",
	"color1",
	"color2",
	"color3",
	"color4",
	"color5",
	"color6",
	"color7",
	"color8",
	"color9",
	"color10",
	"color11",
	"color12",
	"color13",
	"color14",
	"color15",
}

M.tbl_find = function(t, pattern)
	for k, v in pairs(t) do
		if string.find(k, pattern) then
			return v
		end
	end
	return nil
end

M.get_xrdb_color = function()
	local xrdb_query = M.get_xrdb_query()
	local xrdb_color = {}
	for _, color in ipairs(M.color) do
		local pattern = color .. "$"
		xrdb_color[color] = M.tbl_find(xrdb_query, pattern)
	end
	return xrdb_color
end

return M
