local lines = {
	'Lorem ipsum dolor sit amet,',
	'consectetur adipiscing elit.',
	'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
}

local function assert_linewise()
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

local function assert_charwise()
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
	assert.are.equal(lines[#lines]:len() + 1, end_pos[3])
end

describe('unit', function()
	before_each(function()
		-- ensure a clean, empty buffer
		vim.cmd('enew!')
		vim.cmd('normal! <Esc>')

		vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	end)

	it('enters visual mode and selects the entire buffer', function()
		local mod = require('in_its_entirety')

		-- Make sure we are in normal mode before starting
		vim.cmd('normal! <Esc>')

		-- Call the function
		mod.buffer()

		-- Check mode is visual line mode (V)
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('V', mode)

		vim.cmd('normal! <Esc>')

		assert_linewise()
	end)

	it('selects the entire buffer in visual mode (char-wise)', function()
		local mod = require('in_its_entirety')

		-- Make sure we are in normal mode before starting
		vim.cmd('normal! v')

		-- Call the function
		mod.buffer()

		-- Check that mode hasn't changed
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('v', mode)

		vim.cmd('normal! <Esc>')

		assert_charwise()
	end)

	it('selects the entire buffer in visual mode (line-wise)', function()
		local mod = require('in_its_entirety')

		vim.api.nvim_buf_set_lines(0, 0, -1, false, {
			'Lorem ipsum dolor sit amet,',
			'consectetur adipiscing elit.',
			'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
		})

		-- Test linewise mode
		vim.cmd('normal! V')

		-- Call the function
		mod.buffer()

		-- Check mode is visual line mode (V)
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('V', mode)

		vim.cmd('normal! <Esc>')

		assert_linewise()
	end)

	it('selects the entire buffer in visual mode (block)', function()
		local mod = require('in_its_entirety')

		-- Test block-wise mode
		vim.cmd('normal! <C-v>')

		-- Call the function
		mod.buffer()

		-- Check mode is visual line mode (V)
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('V', mode)

		vim.cmd('normal! <Esc>')

		assert_linewise()
	end)
end)
