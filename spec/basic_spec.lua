describe('in_its_entirety', function()
	before_each(function()
		-- ensure a clean, empty buffer
		vim.cmd('enew!')
		vim.api.nvim_buf_set_lines(0, 0, -1, false, {
			'line one',
			'line two',
			'line three',
		})
	end)

	it('loads successfully', function()
		local mod = require('in_its_entirety')
		assert.is_table(mod)
	end)

	it('exposes entire_buffer()', function()
		local mod = require('in_its_entirety')
		assert.is_function(mod.buffer)
	end)
end)
