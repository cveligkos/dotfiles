local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- https://stackoverflow.com/a/11671820
local function map(tbl, f)
	local t = {}
	for i, v in ipairs(tbl) do
		t[i] = f(v)
	end
	return t
end

local function load_file(file)
	local ok, res = pcall(require, file)
	if not ok then
		print("Could not load file: " .. file)
		print(res)
		return nil
	end

	return res
end

local files = {
	"plugins.lualine",
	"plugins.neo-tree",
	"plugins.flash",
	"plugins.trouble",
	"plugins.oil",
	"plugins.treesitter",
	-- "plugins.copilot-lua",
	-- "plugins.copilot-cmp",
	"plugins.nvim-cmp",
	"plugins.lsp",
	"plugins.conform-nvim",
	"plugins.nvim-lint",
	"plugins.lspsaga",
	"plugins.gitsigns",
	"plugins.nvim-surround",
	"plugins.rainbow-delimiters",
	"plugins.luasnip",
	"plugins.which-key",
	"plugins.comment-nvim",
	"plugins.todo-comments",
	"plugins.nvim-autopairs",
	"plugins.indent-blankline",
	-- "plugins.wilder",
	-- "plugins.lsp-signature",
	-- "plugins.noice",
	"plugins.colorizer",
	"plugins.telescope",
	"plugins.dressing",
	-- "plugins.venv-selector",
	"colorschemes.catppuccin",
	"colorschemes.tokyonight",
}
local plugins = map(files, load_file)

local plugin_list = {
	{ "sheerun/vim-polyglot" },
	{ "Fymyte/rasi.vim", ft = "rasi" },
	{ "imsnif/kdl.vim" },
	{ "tpope/vim-fugitive" },
	{ "nathangrigg/vim-beancount" },
}

for _, v in ipairs(plugin_list) do
	table.insert(plugins, v)
end

require("lazy").setup(plugins)
