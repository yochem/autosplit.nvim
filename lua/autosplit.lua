local M = {}

local function autosplit(args)
    local filename = args.args
    local winwidth = vim.fn.winwidth(0)
    local count = args.count

    local vsplit = function()
        -- default is splitting the window in half
        if count == 0 then count = math.floor(vim.fn.winwidth(0) / 2) end
        vim.cmd(count .. 'vsplit ' .. filename)
    end
    local split = function()
        -- default is splitting the window in half
        if count == 0 then count = math.floor(vim.fn.winheight(0) / 2) end
        vim.cmd(count .. 'split ' .. filename)
    end

    if M.config.split == 'auto' then
        if winwidth > 160 then vsplit() else split() end
    elseif M.config.split == 'horizontal' then
        split()
    elseif M.config.split == 'vertical' then
        vsplit()
    end
end

function M.setup(options)
    M.config = options or {split = 'auto'}

    local attributes = {
        desc = 'Automatic split horizontal/vertical based on user preference',
        complete = 'file',
        nargs = '?',
        count = 0
    }

    vim.api.nvim_create_user_command('Split', autosplit, attributes)
    vim.api.nvim_create_user_command('Sp', autosplit, attributes)
end

return M
