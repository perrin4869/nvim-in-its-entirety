local assert = require('luassert')

local M = {}

function M.assert_selection()
	-- Check visual selection start and end marks
	local pos = vim.fn.getregionpos(vim.fn.getpos('v'), vim.fn.getpos('.'))
	local start_pos = pos[1][1] -- [bufnum, lnum, col, off]
	local end_pos = pos[#pos][2]

	-- Buffer should start at line 1, col 1
	assert.are.equal(1, start_pos[2])
	assert.are.equal(1, start_pos[3])
	-- Buffer should end at the last line, last col
	local last_line = vim.api.nvim_buf_line_count(0)
	local last_line_col = vim.api.nvim_buf_get_lines(0, -2, -1, true)[1]:len()
	assert.are.equal(last_line, end_pos[2])
	assert.are.equal(last_line_col, end_pos[3])

	local lines = require('setup').lines
	assert.are.equal(lines[#lines]:len(), end_pos[3])
end

function M.assert_linewise()
	-- Check visual selection start and end marks
	local start_pos = vim.fn.getpos("'<") -- [bufnum, lnum, col, off]
	local end_pos = vim.fn.getpos("'>")

	-- Buffer should start at line 1, col 1
	assert.are.equal(1, start_pos[2])
	assert.are.equal(1, start_pos[3])
	-- Buffer should end at the last line, last col
	local last_line = vim.api.nvim_buf_line_count(0)
	assert.are.equal(last_line, end_pos[2])
	assert.are.equal(vim.v.maxcol, end_pos[3])
end

function M.assert_charwise()
	-- Check visual selection start and end marks
	local start_pos = vim.fn.getpos("'<") -- [bufnum, lnum, col, off]
	local end_pos = vim.fn.getpos("'>")

	-- Buffer should start at line 1, col 1
	assert.are.equal(1, start_pos[2])
	assert.are.equal(1, start_pos[3])
	-- Buffer should end at the last line
	local last_line = vim.api.nvim_buf_line_count(0)
	local last_line_col = vim.api.nvim_buf_get_lines(0, -2, -1, true)[1]:len()
	assert.are.equal(last_line, end_pos[2])
	assert.are.equal(last_line_col + 1, end_pos[3])

	local lines = require('setup').lines
	assert.are.equal(lines[#lines]:len() + 1, end_pos[3])
end

return M
