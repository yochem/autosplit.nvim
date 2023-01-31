local M = {}

local function autosplit(args)
	local split_args = { range = { args.count } }

	-- only add if non-empty because giving an empty string as filename errors
	local filename = args.args
	if filename ~= '' then
		split_args[1] = filename
	end

	local win_height = vim.api.nvim_win_get_height(0)
	local win_width = vim.api.nvim_win_get_width(0)

	local split_cmd = "split"

	-- if auto and there fits another vertical window
	if M.config.split == "auto" and win_width > 2 * M.config.min_win_width then
		split_cmd = "v" .. split_cmd
	end

	-- default is splitting the window in half
	if split_args.range[1] == 0 then
		local winsize = split_cmd:sub(1, 1) == "v" and win_width or win_height
		split_args.range[1] = math.floor(winsize / 2)
	end

	vim.cmd[split_cmd](split_args)
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
