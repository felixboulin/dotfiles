_G.DIAGNOSTIC_SEVERITY_MIN = nil
-- Diagnostic keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'go to previous [d]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'go to next [d]iagnostic message' })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "show diagnostic [e]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- next greatest remap ever : allows to copy into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- moves lines selected in visual mode up and down (will auto indent within blocks)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- appends line to line above with a space. Cutommised to keep the cursor on start of line.
vim.keymap.set("n", "J", "mzJ`z")

-- ensures that the cursor stays in the middle when jumping up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- ensures that the cursor stays in the middle when going to next and previous search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever | when pasting over the selection, it will keep the initial elements that are pasted in the clipboard so they can be pasted again
vim.keymap.set("x", "<leader>p", [["_dP]])

-- deletes to void register | Delete text without storing it in a register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- makes the <C-c> key in insert mode behave like <Esc>
vim.keymap.set("i", "<C-c>", "<Esc>")

-- maps Q to the <nop> command, which does nothing, disabling the default behavior of Q entering Ex mode.
vim.keymap.set("n", "Q", "<nop>")

-- This allows you to quickly open a new tmux window running tmux-sessionizer by pressing Ctrl+f in normal mode. The silent ! prevents any output from being shown.
-- vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww ~/bin/tmux-sessionizer.sh<CR>')

-- reformat the code with LSP integration
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix list
-- vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz') -- next quickfix item, center
-- vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz') -- previous quickfix item, center

-- Location list
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- next location list item, center
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") -- previous location list item, center

-- allows to replace the word under the cursor (all instances)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make the file in the current buffer executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- copy the current file relative path to the clipboard
-- vim.keymap.set('n', '<leader>cf', [[:let @+ = expand('%')<CR>]])
-- copy the current file relative path to git root in git repo
vim.keymap.set("n", "<leader>cf", function()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		git_root = vim.fn.getcwd()
	end
	local full_path = vim.fn.expand("%:p")
	local rel_path = vim.fn.fnamemodify(full_path, ":." .. git_root)
	vim.fn.setreg("+", rel_path)
	vim.fn.setreg('"', rel_path)
	print("Copied git-relative path: " .. rel_path)
end, { desc = "Copy Git-relative file path to clipboard" })

-- copy the current file full path to the clipboard
vim.keymap.set("n", "<leader>cp", [[:let @+ = expand('%:p')<CR>]])

-- copy the current file name to the clipboard
vim.keymap.set("n", "<leader>cn", [[:let @+ = expand('%:t')<CR>]])

-- These mappings control the size of splits (height/width)
vim.keymap.set("n", "<C-Right>", "<c-w>5<")
vim.keymap.set("n", "<C-Left>", "<c-w>5>")
vim.keymap.set("n", "<C-Up>", "<C-W>+")
vim.keymap.set("n", "<C-Down>", "<C-W>-")

vim.keymap.set("t", "<C-o>", "<C-\\><C-n>", { noremap = true })

-- open a new terminal
-- vim.keymap.set('n', '<leader>t', '<cmd>split term://zsh<CR>')
--
-- Function to toggle a terminal or create a new one if none exists
function Toggle_or_create_terminal()
	-- Find existing terminal buffers
	local buffers = vim.api.nvim_list_bufs()
	local terminal_buf = nil
	for _, buf in ipairs(buffers) do
		-- Check if the buffer is a terminal and loaded
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
			terminal_buf = buf
			break
		end
	end

	-- If a terminal buffer was found, open it in a split screen
	if terminal_buf then
		vim.cmd("sb" .. terminal_buf)
		vim.cmd("resize 10") -- Adjust the height of the split as needed
	else
		-- No terminal found, create a new one
		vim.cmd("new +terminal")
		vim.cmd("resize 10") -- Adjust the height of the split as needed
	end
end

-- Mapping leader-t to toggle or create a terminal
vim.api.nvim_set_keymap("n", "<leader>t", ":lua Toggle_or_create_terminal()<CR>", { noremap = true, silent = true })

-- toggle github copilot
-- local copilot_enabled = true
-- local function toggle_copilot()
--   if copilot_enabled then
--     vim.cmd 'Copilot disable'
--     copilot_enabled = false
--     print 'Copilot disabled'
--   else
--     vim.cmd 'Copilot enable'
--     copilot_enabled = true
--     print 'Copilot enabled'
--   end
-- end
-- vim.keymap.set('n', '<leader>gc', toggle_copilot)

-- toggle codeium
local codeium_enabled = true
local function toggle_codeium()
	if codeium_enabled then
		vim.cmd("Codeium Disable")
		codeium_enabled = false
		print("Codeium disabled")
	else
		vim.cmd("Codeium Enable")
		codeium_enabled = true
		print("Codeium enabled")
	end
end
vim.keymap.set("n", "<leader>gc", toggle_codeium)

-- toggle background color
-- local bg_color = 'dark'
-- local function toggle_bg_color()
--   if bg_color == 'dark' then
--     vim.cmd 'set background=light'
--     bg_color = 'light'
--   else
--     vim.cmd 'set background=dark'
--     bg_color = 'dark'
--   end
-- end
-- vim.keymap.set('n', '<leader>bg', toggle_bg_color)

-- toggle set wrap
local wrap = false
local function toggle_wrap()
	if wrap then
		vim.opt.wrap = false
		wrap = false
	else
		vim.opt.wrap = true
		wrap = true
	end
end
vim.keymap.set("n", "<leader>ww", toggle_wrap)

-- prompt for nvim (old plugin)
-- vim.keymap.set('n', '<leader>p', ':lua require("prompt.init").prompt()<CR>')

local function run_promptmd()
	local mdfile = vim.fn.expand("%:p")
	local system_python = "/Library/Frameworks/Python.framework/Versions/3.11/bin/python3"

	if vim.fn.executable(system_python) == 0 then
		system_python = "python3" -- fallback
	end

	vim.system({ system_python, "/Users/felixboulin/bin/promptmd", mdfile }, {
		text = true,
		stdout = function(_, data)
			if data then
				vim.schedule(function()
					vim.notify("Prompt generated and copied to clipboard! 📋", vim.log.levels.INFO)
				end)
			end
		end,
		stderr = function(_, data)
			if data then
				vim.schedule(function()
					vim.notify("❌ Error: " .. data, vim.log.levels.ERROR)
				end)
			end
		end,
	})
end

vim.keymap.set("n", "<leader>p", function()
	if vim.bo.filetype == "markdown" then
		run_promptmd()
	else
		vim.schedule(function()
			vim.notify("Not a markdown file!", vim.log.levels.WARN)
		end)
	end
end, { desc = "Run PromptMD on current file" })

-- crpy entire file to system clipboard
vim.keymap.set("n", "<leader>gg", ":%y+<CR>")

-- search for word below cursor
vim.keymap.set("n", "<leader>l", function()
	local word = vim.fn.expand("<cword>")
	vim.api.nvim_feedkeys("/" .. word, "n", false)
end, { noremap = true, silent = true })

-- clear search registers
vim.keymap.set("n", "<leader>csr", function()
	for _, r in ipairs({
		"a",
		"b",
		"c",
		"d",
		"e",
		"f",
		"g",
		"h",
		"i",
		"j",
		"k",
		"l",
		"m",
		"n",
		"o",
		"p",
		"q",
		"r",
		"s",
		"t",
		"u",
		"v",
		"w",
		"x",
		"y",
		"z",
	}) do
		vim.fn.setreg(r, "")
	end
end, { noremap = true, silent = true })

-- Diagnostic levels
-- View 1: Show everything
vim.keymap.set("n", "<leader>h1", function()
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
	})
	_G.DIAGNOSTIC_SEVERITY_MIN = nil -- no severity filter
	print("Diagnostics: all severities")
end, { desc = "Show all diagnostics" })

-- View 2: Hide hints and info
vim.keymap.set("n", "<leader>h2", function()
	vim.diagnostic.config({
		virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
		signs = { severity = { min = vim.diagnostic.severity.WARN } },
	})
	_G.DIAGNOSTIC_SEVERITY_MIN = vim.diagnostic.severity.WARN
	print("Diagnostics: warnings and errors only")
end, { desc = "Hide hints/info" })

-- View 3: Show only errors
vim.keymap.set("n", "<leader>h3", function()
	vim.diagnostic.config({
		virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
		signs = { severity = { min = vim.diagnostic.severity.ERROR } },
	})
	_G.DIAGNOSTIC_SEVERITY_MIN = vim.diagnostic.severity.ERROR
	print("Diagnostics: errors only")
end, { desc = "Show errors only" })

local function diagnostic_goto_next()
	vim.diagnostic.goto_next({
		severity = _G.DIAGNOSTIC_SEVERITY_MIN and { min = _G.DIAGNOSTIC_SEVERITY_MIN } or nil,
	})
end

local function diagnostic_goto_prev()
	vim.diagnostic.goto_prev({
		severity = _G.DIAGNOSTIC_SEVERITY_MIN and { min = _G.DIAGNOSTIC_SEVERITY_MIN } or nil,
	})
end

vim.keymap.set("n", "]d", diagnostic_goto_next, { desc = "Go to next diagnostic with severity filter" })
vim.keymap.set("n", "[d", diagnostic_goto_prev, { desc = "Go to previous diagnostic with severity filter" })
