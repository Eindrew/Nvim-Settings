-- Make the function local to this file/module
local function compile_tex_async()
	-- Get filename without directory or extension (original method)
	local filename = vim.fn.expand("%:t:r")
	-- Get the directory containing the file
	local file_dir = vim.fn.expand("%:p:h")
	-- Get the full path of the file
	local full_path = vim.fn.expand("%:p")

	-- Check if we have a filename (might be an empty buffer)
	if filename == "" then
		vim.notify("No filename to compile.", vim.log.levels.WARN)
		return
	end

	vim.notify("Running pdflatex asynchronously for file: " .. filename .. ".tex ...", vim.log.levels.INFO)

	-- Construct the command string (closer to original, but using full path and escaping)
	-- Using shellescape is crucial for filenames with spaces or special characters.
	local cmd_str = "pdflatex -interaction=nonstopmode -output-directory="
		.. vim.fn.shellescape(file_dir)
		.. " "
		.. vim.fn.shellescape(full_path)

	-- Use vim.fn.jobstart to run the command asynchronously
	local job_id = vim.fn.jobstart(cmd_str, {
		-- Capture stderr and print it using vim.notify
		on_stderr = function(_, data, _)
			-- Filter out empty lines often produced by stderr callbacks
			local stderr_output = table.concat(
				vim.tbl_filter(function(line)
					return line ~= ""
				end, data),
				"\n"
			)
			if stderr_output ~= "" then
				vim.notify("[pdflatex stderr]:\n" .. stderr_output, vim.log.levels.WARN)
			end
		end,
		-- Capture stdout and print it using vim.notify (optional, can be verbose)
		-- on_stdout = function(_, data, _)
		--   local stdout_output = table.concat(vim.tbl_filter(function(line) return line ~= '' end, data), "\n")
		--   if stdout_output ~= '' then
		--      vim.notify("[pdflatex stdout]:\n" .. stdout_output, vim.log.levels.INFO)
		--   end
		-- end,
		-- Callback function when the job exits
		on_exit = function(_, code, _)
			if code == 0 then
				vim.notify("pdflatex command executed successfully for " .. filename .. ".pdf", vim.log.levels.INFO)
			else
				vim.notify(
					"pdflatex command failed for " .. filename .. ".tex (exit code: " .. code .. ")",
					vim.log.levels.ERROR
				)
				-- Optional: Automatically open the log file on error
				-- local log_file = file_dir .. "/" .. filename .. ".log"
				-- if vim.fn.filereadable(log_file) == 1 then
				--   vim.cmd("edit " .. vim.fn.fnameescape(log_file))
				-- end
			end
		end,
		-- Detach the process so Neovim doesn't wait for it
		detach = true,
		-- Set the working directory for the command (original method)
		cwd = file_dir,
		-- Specify that the command is a shell command string
		pty = false, -- Don't need a pseudo-terminal
	})

	-- Check if the job started successfully
	if job_id and job_id > 0 then
		vim.notify("pdflatex command started in the background (Job ID: " .. job_id .. ").", vim.log.levels.INFO)
	elseif job_id == 0 then
		vim.notify("pdflatex command failed immediately (Job ID: 0). Check command syntax.", vim.log.levels.ERROR)
	elseif job_id == -1 then
		vim.notify("Invalid arguments provided to jobstart for pdflatex.", vim.log.levels.ERROR)
	else
		vim.notify("Failed to start pdflatex command.", vim.log.levels.ERROR)
	end
end

-- Create an autocommand group to ensure clean setup/teardown
-- Use a unique name to avoid conflicts
local tex_compile_async_group = vim.api.nvim_create_augroup("TexCompileAsyncOnSave", { clear = true })

-- Create the autocommand using Lua API
vim.api.nvim_create_autocmd("BufWritePost", {
	group = tex_compile_async_group,
	pattern = "*.tex", -- Trigger only for .tex files
	desc = "Automatically compile .tex file to .pdf using pdflatex on save (adapted)",
	callback = compile_tex_async, -- Call our Lua function
})

-- vim.notify("TeX async auto-compilation on save enabled (adapted).", vim.log.levels.INFO)

-- Return an empty table, standard practice for lazy.nvim plugin files
-- that only set up autocommands or options.
return {}
