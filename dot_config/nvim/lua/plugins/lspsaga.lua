return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			lightbulb = {
				virtual_text = false,
			},
		})
	end,
}
