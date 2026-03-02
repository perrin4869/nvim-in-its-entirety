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
end)
