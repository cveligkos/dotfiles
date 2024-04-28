local status, _ = pcall(vim.cmd, "colorscheme ayu-dark")

if not status then
	print("Colorscheme not found")
	return
end

-- require("ayu").colorscheme()
