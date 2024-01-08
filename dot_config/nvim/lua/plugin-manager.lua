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
function map(tbl, f)
	local t = {}
	for i, v in ipairs(tbl) do
		t[i] = f(v)
	end
	return t
end

function load_file(file)
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
	"plugins.nvim-tree",
	"plugins.flash",
	"plugins.trouble",
	"plugins.oil",
	"plugins.treesitter",
	"plugins.neorg",
	"plugins.nvim-cmp",
	"plugins.lspconfig",
	"plugins.lsp-signature",
	"plugins.lspsaga",
	"plugins.gitsigns",
	"plugins.fugitive",
	"plugins.polyglot",
	"plugins.nvim-surround",
	"plugins.rainbow-delimiters",
	"plugins.luasnip",
	"plugins.null-ls",
	"plugins.which-key",
	"plugins.comment-nvim",
	"plugins.todo-comments",
	"plugins.nvim-autopairs",
	"plugins.kdl",
	"plugins.beancount",
	-- "plugins.noice",
	"plugins.indent-blankline",
	"plugins.wilder",
	-- "plugins.navigator",
	"plugins.colorizer",
	"plugins.rasi-vim",
	"plugins.telescope",
	"plugins.dressing",
	-- "plugins.venv-selector",
	"colorschemes.catppuccin",
	"colorschemes.tokyonight",
}

local plugins = map(files, load_file)
require("lazy").setup(plugins)
