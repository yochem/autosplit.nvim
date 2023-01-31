local M = {}

local function autosplit(args)
	local count = args.count

	local split_args = { range = { count } }
	if args.args ~= '' then
		split_args[1] = args.args
	end

	local winwidth = vim.fn.winwidth(0)
	local winheight = vim.fn.winheight(0)

	local vsplit = function()
		-- default is splitting the window in half
		if count == 0 then
			split_args.range = {math.floor(winwidth / 2)}
		end
		vim.cmd.vsplit(split_args)
	end

	local split = function()
		-- default is splitting the window in half
		if count == 0 then
			split_args.range = {math.floor(winheight / 2)}
		end
		vim.cmd.split(split_args)
	end

	if M.config.split == "auto" then
		-- if there fits another vertical window
		if winwidth > 2 * M.config.min_win_width then
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
	M.config = vim.tbl_extend('keep', options, default_opts)

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
