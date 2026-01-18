---@brief [[
---*in_its_entirety.txt*   Select the entire buffer as an operator target
---@brief ]]
---
---@mod in_its_entirety Select the entire buffer in visual or operator-pending mode

local M = {}

---Select the entire current buffer.
---
---This function computes the full buffer range and ensures Neovim
---ends in Visual mode so that operators apply correctly.
---
---It is safe to call from:
---  - Visual mode
---  - Operator-pending mode
---
---Typical usage:
---
---```lua
---vim.keymap.set(
---  { "x", "o" },
---  "ae",
---  require("in_its_entirety").buffer,
---  { desc = "Entire buffer" }
---)
---```
---
---@return nil
function M.buffer()
	local buf = 0

	local start_row, start_col = 0, 0
	local end_row = vim.api.nvim_buf_line_count(buf) - 1
	local last_line_content = vim.api.nvim_buf_get_lines(buf, end_row, end_row + 1, true)[1] or ''
	local end_col = math.max(0, #last_line_content)

	local foo = 'omg'

	-- Enter Visual mode if needed.
	-- Operators only apply if the mapping terminates in Visual mode.
	local mode = vim.api.nvim_get_mode().mode
	if mode ~= 'V' and mode ~= 'v' and mode ~= '\22' then
		vim.cmd.normal({ 'V', bang = true })
	end

	vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
	vim.cmd.normal({ 'o', bang = true }) -- Swap cursor to other end (:help v_o)
	vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
end

return M
