local M = {}

M.lines = {
	'Lorem ipsum dolor sit amet,',
	'consectetur adipiscing elit.',
	'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
}

function M.setup()
	-- ensure a clean, empty buffer
	vim.cmd('enew!')
	vim.cmd('normal! <Esc>')

	vim.api.nvim_buf_set_lines(0, 0, -1, false, M.lines)
end

return M
