local ok, mason = pcall(require, "mason")
if not ok then
	vim.notify("unable to load 'mason' plugin when trying to config")
	return
end

local ok_config, mason_config = pcall(require, "mason-lspconfig")
if not ok_config then
	vim.notify("loaded 'mason' plugin but unable to load 'mason-lspconfig' plugin!")
	return
end

local servers = {
	"pyright",
	"gopls",
	"pyright",
	"rust_analyzer",
	"tsserver",
	"html",
	"yamlls",
	"cssls",
	"stylelint_lsp",
	"volar",
	"bashls",
	"jsonls",
	"astro",
	"marksman",
	"emmet_ls",
	"vimls",
	"ansiblels",
	"dockerls",
}
local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_config.setup {
	ensure_installed = servers,
	automatic_installation = true,
}

local lsp_config_found, lspconfig = pcall(require, "lspconfig")
if not lsp_config_found then
	vim.notify("The 'lspconfig' module not found while configuring Mason")
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	server = vim.split(server, "@")[1]
	local found_config_for_lang, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if found_config_for_lang then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end
	lspconfig[server].setup(opts)
end
