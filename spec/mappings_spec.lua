describe('mappings', function()
	before_each(function()
		require('setup').setup()

		pcall(vim.keymap.del, 'x', 'ae')
		pcall(vim.keymap.del, 'o', 'ae')
	end)

	it('selects the entire buffer in visual mode (char-wise)', function()
		vim.keymap.set('x', 'ae', function()
			require('in_its_entirety').buffer()
		end, { desc = 'Select entire buffer' })

		-- Call the mapping
		vim.cmd('normal vae')

		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('v', mode)

		require('assertions').assert_selection()
		vim.cmd('normal! <Esc>')
		require('assertions').assert_charwise()
	end)

	it('selects the entire buffer in visual mode (line-wise)', function()
		vim.keymap.set('x', 'ae', function()
			require('in_its_entirety').buffer()
		end, { desc = 'Select entire buffer' })

		-- Call the mapping
		vim.cmd('normal Vae')

		-- Check mode is visual line mode (V)
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('V', mode)

		require('assertions').assert_selection()
		vim.cmd('normal! <Esc>')
		require('assertions').assert_linewise()
	end)

	it('selects the entire buffer in visual mode (block)', function()
		vim.keymap.set('x', 'ae', function()
			require('in_its_entirety').buffer()
		end, { desc = 'Select entire buffer' })

		-- Call the mapping
		vim.cmd('normal \22ae')

		-- Check mode is visual line mode (V)
		local mode = vim.api.nvim_get_mode().mode
		assert.are.equal('\22', mode)

		require('assertions').assert_selection()
		vim.cmd('normal! <Esc>')
		require('assertions').assert_charwise()
	end)

	it('works in operator-pending mode (yank)', function()
		vim.keymap.set('o', 'ae', function()
			require('in_its_entirety').buffer()
		end, { desc = 'Select entire buffer' })

		-- Clear unnamed register first
		vim.fn.setreg('"', '')

		-- Call the mapping
		vim.cmd('normal yae')

		assert.are.equal(table.concat(require('setup').lines, '\n') .. '\n', vim.fn.getreg('"'))

		local regtype = vim.fn.getregtype('"')
		assert.are.equal('V', regtype) -- linewise yank
	end)
end)
