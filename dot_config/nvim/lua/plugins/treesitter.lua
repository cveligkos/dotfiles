return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"css",
				"diff",
				"dockerfile",
				"git_config",
				"git_rebase",
				"go",
				"gomod",
				"gosum",
				"html",
				"htmldjango",
				"javascript",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"markdown_inline",
				"nix",
				"php",
				"phpdoc",
				"python",
				"rust",
				"scss",
				"sql",
				"svelte",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
				"yuck",
			},
			highlight = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			indent = {
				enable = false,
			},
		})
	end,
}
