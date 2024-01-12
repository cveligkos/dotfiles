return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- language servers
				"lua_ls",
				"rust_analyzer",
				"intelephense",
				"tailwindcss-language-server",

				-- formatters
				"stylua",
				"prettierd",
				"isort",
				"black",
				"rustywind",

				--linters
				"eslint_d",
				"selene",
			},
		})
	end,
}
