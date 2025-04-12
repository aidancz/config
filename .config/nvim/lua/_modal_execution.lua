-- # add mode

require("modal_execution").add_mode({
	name = "example",
	config1 = {
	-- mode specific data here
	},
	func = function(self, config2)
		local config0 = {
			time = os.time(),
			direction = "prev",
			count = vim.v.count,
			wrap = true,
		}
		local config1 = self.config1 or {}
		local config2 = config2 or {}
		local config = vim.tbl_extend(
			"force",
			config0,
			config1,
			config2
		)
		vim.notify(vim.inspect(config))
	end,
	setup = function(self)
		-- vim.keymap.set("n", "x", function() self:func() end)
		vim.keymap.set("n", "r", function() self:func({direction = "prev"}) end)
		vim.keymap.set("n", "m", function() self:func({direction = "next"}) end)
	end,
})
require("modal_execution").set_current_mode("example")

-- require("modal_execution").add_mode({
-- 	name = "buffer",
-- 	setup = function()
-- 		vim.keymap.set("n", "r", "[b", {remap = true})
-- 		vim.keymap.set("n", "m", "]b", {remap = true})
-- 	end,
-- })

require("modal_execution").add_mode({
	name = "buffer",
	config1 = {
	},
	func = function(self, config2)
		local config0 = {
			direction = "prev",
			count = vim.v.count,
		}
		local config1 = self.config1 or {}
		local config2 = config2 or {}
		local config = vim.tbl_extend(
			"force",
			config0,
			config1,
			config2
		)
		if config.count == 0 then config.count = 1 end
		local buf = vim.api.nvim_get_current_buf()
		local buf_list = vim.api.nvim_list_bufs()
		local buf_is_listed = function(buf)
			if buf == 0 then return false end
			-- https://github.com/neovim/neovim/issues/33270
			return vim.fn.buflisted(buf) ~= 0
		end
		if config.direction == "prev" then
			local prev
			prev = function(buf)
				if buf_is_listed(buf - 1) then
					return (buf - 1)
				end
				if (buf - 1) < buf_list[1] then
					return prev(buf_list[#buf_list] + 1)
				end
				return prev(buf - 1)
			end
			for i = 1, config.count do
				buf = prev(buf)
			end
			vim.api.nvim_set_current_buf(buf)
		else
			local next
			next = function(buf)
				if buf_is_listed(buf + 1) then
					return (buf + 1)
				end
				if (buf + 1) > buf_list[#buf_list] then
					return next(buf_list[1] - 1)
				end
				return next(buf + 1)
			end
			for i = 1, config.count do
				buf = next(buf)
			end
			vim.api.nvim_set_current_buf(buf)
		end
	end,
	setup = function(self)
		vim.keymap.set("n", "r", function() self:func({direction = "prev"}) end)
		vim.keymap.set("n", "m", function() self:func({direction = "next"}) end)
	end,
})

require("modal_execution").add_mode({
	name = "window",
	config1 = {
	},
	func = function(self, config2)
		local config0 = {
			direction = "prev",
			count = vim.v.count,
		}
		local config1 = self.config1 or {}
		local config2 = config2 or {}
		local config = vim.tbl_extend(
			"force",
			config0,
			config1,
			config2
		)
		if config.count == 0 then config.count = "" end
		if config.direction == "prev" then
			vim.cmd(config.count .. "wincmd W")
		else
			vim.cmd(config.count .. "wincmd w")
		end
	end,
	setup = function(self)
		vim.keymap.set("n", "r", function() self:func({direction = "prev"}) end)
		vim.keymap.set("n", "m", function() self:func({direction = "next"}) end)
	end,
})

require("modal_execution").add_mode({
	name = "undo",
	setup = function()
		vim.keymap.set("n", "r", "<c-r>")
	end,
})

-- # keymap

vim.keymap.set(
	"n",
	"fj",
	function()
		require("modal_execution").set_current_mode("buffer")
	end
)

vim.keymap.set(
	"n",
	"fk",
	function()
		require("modal_execution").set_current_mode("window")
	end
)

vim.keymap.set(
	"n",
	"u",
	function()
		require("modal_execution").set_current_mode("undo")
		return "u"
	end,
	{
		expr = true,
	}
)
