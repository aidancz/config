-- # mode list

local mode_list = {
	{
		name = "test",
		config1 = {
		-- mode specific data here
		},
		func = function(self, config2)
			local config0 = {
				time = os.time(),
				direction = "backward",
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
			vim.keymap.set("n", "x", function() self:func() end)
			vim.keymap.set("n", "r", function() self:func({direction = "backward"}) end)
			vim.keymap.set("n", "m", function() self:func({direction = "forward"})  end)
		end,
	},
	{
		name = "buffer",
		setup = function()
			vim.keymap.set("n", "r", "[b", {remap = true})
			vim.keymap.set("n", "m", "]b", {remap = true})
		end,
	},
	{
		name = "window",
		config1 = {
		},
		func = function(self, config2)
			local config0 = {
				direction = "backward",
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
			if config.direction == "backward" then
				vim.cmd(config.count .. "wincmd W")
			else
				vim.cmd(config.count .. "wincmd w")
			end
		end,
		setup = function(self)
			vim.keymap.set("n", "r", function() self:func({direction = "backward"}) end)
			vim.keymap.set("n", "m", function() self:func({direction = "forward"})  end)
		end,
	},
	{
		name = "undo",
		setup = function()
			vim.keymap.set("n", "r", "<c-r>")
		end,
	},
}

-- # setup

require("modal_execution").setup({
	mode_list = mode_list,
	default_mode = "test",
})

-- # keymap

local map = function(mode, lhs, rhs_expr, opts)
	vim.keymap.set(
		"n",
		lhs,
		function()
			require("modal_execution").set_current_mode(mode)
			return rhs_expr or ""
		end,
		vim.tbl_extend(
			"force",
			{
				expr = true,
				remap = true,
			},
			opts or {}
		)
	)
end

map("buffer", "fj")

map("window", "fk")

map("undo", "u", "u")
