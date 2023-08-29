local ok, scroll = pcall(require, "neoscroll")
if not ok then
	vim.notify("Failure to load neoscroll plugin for configuration; can be ignored during bootstrapping")
	return
end

-- https://github.com/karb94/neoscroll.nvim
scroll.setup({
	mappings = {
		'<C-u>', '<C-d>', '<C-b>', '<C-f>',
    '<C-y>', '<C-e>', 'zt', 'zz', 'zb'
	},
	hide_cursor = true,
	stop_eof = true,
	respect_scroll_alone = true,
	easing_function = nil,
	pre_hook = nill,
	post_hook = nill,
	performance_mode = true
})
