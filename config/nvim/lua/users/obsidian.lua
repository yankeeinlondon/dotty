local ok, obsidian = pcall(require, "obsidian")
if not ok then
	vim.notify "Failed to load userland obsidian config!"
end

obsidian.setup {
	dir = "~/drive/documents/notes",
	completion = {
		nvim_cmp = true,
	},
}

