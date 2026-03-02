local _MODREV, _SPECREV = 'scm', '-1'
rockspec_format = '3.0'
package = 'nvim-in-its-entirety'
version = _MODREV .. _SPECREV
description = {
	summary = 'Neovim text object for operating on the entire buffer.',
	detailed = [[
  A minimal Neovim plugin that provides an operator- and visual-mode target
  for the entire buffer, enabling commands like dae and yae to operate on the 
  whole file correctly.
  ]],
	labels = {
		'neovim',
		'plugin',
		'textobj',
	},
	homepage = 'https://github.com/dotcore64/nvim-in-its-entirety',
	license = 'GPL-3.0',
}
dependencies = {
	'lua ~> 5.1',
	-- 'lua >= 5.1, <= 5.4',
}
test_dependencies = {
	'nlua',
}
source = {
	url = 'git://github.com/dotcore64/nvim-in-its-entirety',
}
build = {
	type = 'builtin',
	copy_directories = {
		'doc',
	},
}
