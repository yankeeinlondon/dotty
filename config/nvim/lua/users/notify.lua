local ok, notify = pcall(require, "notify")
if not ok then
	vim.notify "Failed to load user.notify!"
	return
end

local notice = function(title, body, level)
	notify({ title = title or  "Notification" }, body, { level = level or "info" })
end

return notice
