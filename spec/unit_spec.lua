describe('unit', function()
	before_each(function()
		require('setup').setup()
	end)

	it('enters visual mode and selects the entire buffer', function()
		local mod = require('in_its_entirety')

		-- Call the function
		mod.buffer()

		-- Check mode is visual line mode (V)
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('V', mode)

		require('assertions').assert_selection()
		vim.cmd('normal! <Esc>')
		require('assertions').assert_linewise()
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

		require('assertions').assert_selection()
		vim.cmd('normal! <Esc>')
		require('assertions').assert_charwise()
	end)

	it('selects the entire buffer in visual mode (line-wise)', function()
		local mod = require('in_its_entirety')

		-- Test linewise mode
		vim.cmd('normal! V')

		-- Call the function
		mod.buffer()

		-- Check mode is visual line mode (V)
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('V', mode)

		require('assertions').assert_selection()
		vim.cmd('normal! <Esc>')
		require('assertions').assert_linewise()
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

		require('assertions').assert_selection()
		vim.cmd('normal! <Esc>')
		require('assertions').assert_linewise()
	end)

	it('sets the previous context mark', function()
		local mod = require('in_its_entirety')

		vim.api.nvim_win_set_cursor(0, { 2, 7 })
		local original = vim.api.nvim_win_get_cursor(0)

		vim.cmd('normal! v')
		mod.buffer()

		local new_cursor = vim.api.nvim_win_get_cursor(0)
		local last_line = vim.api.nvim_buf_line_count(0)
		local last_col = vim.api.nvim_buf_get_lines(0, -2, -1, true)[1]:len()
		assert.are.same(new_cursor, { last_line, last_col })

		local mark = vim.api.nvim_buf_get_mark(0, "'")
		assert.are.same(original, mark)
	end)
end)
