local M = {}
--------------------------------------------------------------------------------
function M.init()
	M.tmpFile = os.tmpname()
	os.execute("whoami > " .. M.tmpFile)
	local whoamiFile = io.open(M.tmpFile, "r")
	M.user = whoamiFile:read()
	whoamiFile:close()
	M.psCommand = "ps -u " .. M.user .. " -U " .. M.user .. " u > " .. M.tmpFile
	vim.inspect(M)
end

--------------------------------------------------------------------------------
function M.selectAndWait(items, prompt, format)
	local co = coroutine.running()
	if co then
		cb = function(item)
			coroutine.resume(co, item)
		end
	end
	cb = vim.schedule_wrap(cb)
	vim.ui.select(items, {
		prompt = prompt,
		format_item = format,
	}, cb)
	if co then
		return coroutine.yield()
	end
end

--------------------------------------------------------------------------------------------
function M.processesWithName(name)
	os.execute("ps | grep " .. name .. " > M.tmpFile")
	-- read the tmp file line by line
	local processes = {}
	for line in io.lines(M.tmpFile) do
		table.insert(processes, line)
	end
	return processes
end

--------------------------------------------------------------------
function M.processesOfUser()
	os.execute(M.psCommand)
	-- read the tmp file line by line
	local processes = {}
	local first = true -- for omitting table header line
	for processString in io.lines(M.tmpFile) do
		if first then
			first = false
		else
			local process = {}
			for token in string.gmatch(processString, "[^%s]+") do
				table.insert(process, token)
			end
			table.insert(processes, process)
		end
	end
	return processes
end

--------------------------------------------------------------------------------
function M.setup()
	local dap = require("dap")

	dap.adapters.cppdbg = {
		name = "cpptools",
		type = "server",
		port = "4711",
		--args = "--server=4711",
		command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
	}

	dap.adapters.codelldb = {
		name = "codelldb server",
		type = "server",
		port = "${port}",
		executable = {
			command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
			args = { "--port", "${port}" },
		},
	}

	dap.configurations.cpp = {
		{
			name = "Attach to process",
			type = "cppdbg",
			request = "attach",
			processId = function()
				local process = M.selectAndWait(M.processesOfUser(), "Select process", function(process)
					return process[11] .. " (" .. process[2] .. ")"
				end)
				local pid = process[2]
				local path = process[11]
				dap.configurations.cpp[1].program = path
				print(path)
				return pid
			end,
		},
		--{
		--  name = 'Attach to StarCCM+',
		--  type = 'cppdbg',
		--  request = 'attach',
		--  processId = function()
		--    -- execute linux ps and get PIDs and process names. write the output to a tmp file
		--    local ps = M.processesWithName('starccm+')
		--
		--    if (length(ps) == 0) then
		--      return ''
		--    elseif (length(ps) == 1) then
		--      local pid = ps[1]
		--      local line = {}
		--      for token in string.gmatch(item, "[^%s]+") do
		--        table.insert(line, token)
		--      end
		--      pid = line[1]
		--    else
		--      local pid = M.selectAndWait(processes, "Select process")
		--      local line = {}
		--      for token in string.gmatch(item, "[^%s]+") do
		--        table.insert(line, token)
		--      end
		--      pid = line[1]
		--    end
		--    return pid
		--  end,
		--},
	}
	dap.configurations.c = dap.configurations.cpp
end

M.init()
return M
