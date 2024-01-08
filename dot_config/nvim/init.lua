local modules = {
	"core.options",
	"core.keymaps",
	"plugin-manager",
	"core.colorscheme",
}

for _, v in ipairs(modules) do
	local ok, res = pcall(require, v)

	if not ok then
		print("Module could not be loaded: " .. v)
		print(res)
	end
end
