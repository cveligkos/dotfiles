return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- language servers
				"lua_ls",
				"rust_analyzer",
				"intelephense",

				-- formatters
				"stylua",
				"prettierd",
				"isort",
				"black",

				--linters
				"eslint_d",
				"selene",
			},
		})
	end,
}
