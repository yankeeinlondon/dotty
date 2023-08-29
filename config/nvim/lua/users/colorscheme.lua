local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("the colorscheme " .. colorscheme .. " is not installed")
	return
end

-- vim.cmd [[
-- colorscheme tokyonight
-- ]]
