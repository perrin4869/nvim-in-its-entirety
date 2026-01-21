describe('in_its_entirety', function()
	before_each(function()
		-- ensure a clean, empty buffer
		vim.cmd('enew!')
		vim.cmd('normal! <Esc>')
		vim.api.nvim_buf_set_lines(0, 0, -1, false, {
			'line one',
			'line two',
			'line three',
		})
	end)

	it('exposes entire_buffer()', function()
		local mod = require('in_its_entirety')
		assert.is_function(mod.buffer)
	end)

	it('enters visual mode and selects the entire buffer', function()
		local mod = require('in_its_entirety')

		vim.api.nvim_buf_set_lines(0, 0, -1, false, {
			'Lorem ipsum dolor sit amet,',
			'consectetur adipiscing elit.',
			'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
		})

		-- Make sure we are in normal mode before starting
		vim.cmd('normal! <Esc>')

		-- Call the function
		mod.buffer()

		-- Check mode is visual line mode (V)
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('V', mode)

		vim.cmd('normal! <Esc>')

		-- Check visual selection start and end marks
		local start_pos = vim.fn.getpos("'<") -- [bufnum, lnum, col, off]
		local end_pos = vim.fn.getpos("'>")

		-- Buffer should start at line 1
		assert.are.equal(1, start_pos[2])
		-- Buffer should end at the last line
		local last_line = vim.api.nvim_buf_line_count(0)
		assert.are.equal(last_line, end_pos[2])
	end)

	it('selects the entire buffer in visual mode (char-wise)', function()
		local mod = require('in_its_entirety')

		vim.api.nvim_buf_set_lines(0, 0, -1, false, {
			'Lorem ipsum dolor sit amet,',
			'consectetur adipiscing elit.',
			'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
		})

		-- Make sure we are in normal mode before starting
		vim.cmd('normal! v')

		-- Call the function
		mod.buffer()

		-- Check mode is visual line mode (V)
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('v', mode)

		vim.cmd('normal! <Esc>')

		-- Check visual selection start and end marks
		local start_pos = vim.fn.getpos("'<") -- [bufnum, lnum, col, off]
		local end_pos = vim.fn.getpos("'>")

		-- Buffer should start at line 1
		assert.are.equal(1, start_pos[2])
		-- Buffer should end at the last line
		local last_line = vim.api.nvim_buf_line_count(0)
		assert.are.equal(last_line, end_pos[2])
	end)
end)
