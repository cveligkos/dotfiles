return {
	"ray-x/navigator.lua",
	dependencies = {
		{ "ray-x/guihua.lua", build = "cd lua/fzy && make" },
		{ "neovim/nvim-lspconfig" },
	},
	config = function()
		require("navigator").setup({
			lsp = {
				code_action = {
					enable = false,
					virtual_text = false,
				},

				diagnostic = {
					virtual_text = false,
				},
			},
		})
	end,
}
