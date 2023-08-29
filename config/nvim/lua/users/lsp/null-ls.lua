
local ok, null_ls = pcall(require, "null-ls")
if not ok then
	vim.notify "Failed to load userland config for null-ls!"
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
null_ls.setup {
	debug = false,
	sources = {
		formatting.eslint_d,
		formatting.yamlfmt,
		formatting.stylelint,
		formatting.rustfmt,
		formatting.prettierd,
		formatting.stylua,
		formatting.nginx_beautifier,
		formatting.prettierd,
		-- diagnostics
		diagnostics.eslint_d,
		diagnostics.markdownlint.with {
			MD025 = false,
			MD013 = false,
			MD033 = false,
			MD026 = false,
		},
		diagnostics.actionlint,
		diagnostics.ansiblelint,
	},
}
