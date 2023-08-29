local ok, lualine = pcall(require, "lualine")
if not ok then
	vim.notify("unable to load userland lualine config!")
end

-- Set lualine as statusline
-- See `:help lualine.txt`
local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}
local filename = {
	"filename",
	path = 1,
	file_status = true,
	symbols = { modified = "[+]", readonly = "[-]", unnamed = "", newfile = "[New]" },
}
local location = {
	"location",
	padding = 0,
}
local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		-- theme = "onedark",
		component_separators = "|",
		section_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { filename },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { "progress", location, "filesize" },
		lualine_y = { "diagnostics" },
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
