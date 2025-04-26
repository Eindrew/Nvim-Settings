return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")
		-- recomended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Define the function that runs when nvim-tree attaches to a buffer
		local function my_nvim_tree_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			local function change_cwd_to_node()
				local node = api.tree.get_node_under_cursor() -- Use the API module
				if not node or not node.absolute_path then
					vim.notify("Nvim-tree: No node found under cursor.", vim.log.levels.WARN)
					return
				end
				local path = node.absolute_path
				local target_dir
				if vim.fn.isdirectory(path) == 1 then
					target_dir = path
				else
					target_dir = vim.fn.fnamemodify(path, ":h")
				end
				if target_dir == "." or target_dir == "" then
					target_dir = vim.fn.getcwd()
					vim.notify("Nvim-tree: Cannot 'cd' to parent of this node.", vim.log.levels.WARN)
					return
				end
				local escaped_dir = vim.fn.fnameescape(target_dir)
				vim.api.nvim_command("cd " .. escaped_dir)
				vim.notify("Changed CWD to: " .. target_dir, vim.log.levels.INFO)
			end

			-- Set the buffer-local keymap inside the on_attach function
			vim.keymap.set("n", "<Leader>cd", change_cwd_to_node, {
				buffer = bufnr, -- <<< IMPORTANT: Make it buffer-local
				noremap = true,
				silent = true, -- Optional: prevents command echo, notify still works
				desc = "NvimTree: Change CWD to node directory", -- Description for which-key
			})

			-- You can add other nvim-tree buffer-local mappings here too
			-- Example: vim.keymap.set("n", "Y", function() api.fs.copy_path() end, { buffer = bufnr, desc = "NvimTree: Copy Path" })

			-- Keep default mappings unless you want to fully override
			-- nvimtree.setup_buffer(bufnr) -- May or may not be needed depending on nvim-tree version and goals
		end

		nvimtree.setup({

			on_attach = my_nvim_tree_on_attach,

			view = {
				width = 35,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for explorer to work well with window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},

			filters = {
				custom = { ".DS_Store" },
			},

			git = {
				ignore = false,
			},
		})

		-- set keymaps

		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
} -- End of returned table
