local M = {}

local function autosplit(args)
	local filename = args.args
	local count = args.count

	local winwidth = vim.fn.winwidth(0)
	local winheight = vim.fn.winheight(0)

	local vsplit = function()
		-- default is splitting the window in half
		if count == 0 then
			count = math.floor(winwidth / 2)
		end
		vim.cmd.vsplit({ filename, range = { count } })
	end

	local split = function()
		-- default is splitting the window in half
		if count == 0 then
			count = math.floor(winheight / 2)
		end
		vim.cmd.split({ filename, range = { count } })
	end

	if M.config.split == "auto" then
		-- if there fits another vertical window
		if winwidth > 2 * M.min_win_width then
			vsplit()
		else
			split()
		end
	elseif M.config.split == "horizontal" then
		split()
	elseif M.config.split == "vertical" then
		vsplit()
	end
end

function M.setup(options)
	local default_opts = {
		split = "auto",
		min_win_width = 80,
	}
	M.config = vim.tbl_extend('force', default_opts, options)

	local attributes = {
		desc = 'lua require("autosplit").autosplit',
		complete = "file",
		nargs = "?",
		count = 0,
	}

	vim.api.nvim_create_user_command("Split", autosplit, attributes)
	vim.api.nvim_create_user_command("Sp", autosplit, attributes)
end

return M
