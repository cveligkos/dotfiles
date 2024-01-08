return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for filesystem path
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets

		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		-- "onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- load vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = {
				-- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
		})

		-- local lspkind = require("lspkind")

		-- local has_words_before = function()
		-- 	unpack = unpack or table.unpack
		-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		-- end
		--
		-- cmp.setup({
		-- 	preselect = cmp.PreselectMode.None,
		-- 	snippet = {
		-- 		-- REQUIRED - you must specify a snippet engine
		-- 		expand = function(args)
		-- 			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		-- 		end,
		-- 	},
		-- 	window = {
		-- 		completion = cmp.config.window.bordered(),
		-- 		documentation = cmp.config.window.bordered(),
		-- 	},
		-- 	mapping = cmp.mapping.preset.insert({
		-- 		["<Tab>"] = cmp.mapping(function(fallback)
		-- 			if cmp.visible() then
		-- 				cmp.select_next_item()
		-- 				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
		-- 				-- they way you will only jump inside the snippet region
		-- 			elseif luasnip.expand_or_jumpable() then
		-- 				luasnip.expand_or_jump()
		-- 			elseif has_words_before() then
		-- 				cmp.complete()
		-- 			else
		-- 				fallback()
		-- 			end
		-- 		end, { "i", "s" }),
		--
		-- 		["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 			if cmp.visible() then
		-- 				cmp.select_prev_item()
		-- 			elseif luasnip.jumpable(-1) then
		-- 				luasnip.jump(-1)
		-- 			else
		-- 				fallback()
		-- 			end
		-- 		end, { "i", "s" }),
		--
		-- 		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- 		["<C-Space>"] = cmp.mapping.complete(),
		-- 		["<C-e>"] = cmp.mapping.abort(),
		-- 		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		-- 	}),
		-- 	sources = cmp.config.sources({
		-- 		{ name = "nvim_lsp" },
		-- 		{ name = "luasnip" }, -- For luasnip users.
		-- 	}, {
		-- 		{ name = "buffer" },
		-- 	}),
		-- 	formatting = {
		-- 		format = lspkind.cmp_format({
		-- 			mode = "symbol", -- show only symbol annotations
		-- 			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		-- 			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
		--
		-- 			-- The function below will be called before any actual modifications from lspkind
		-- 			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
		-- 			-- before = function (entry, vim_item)
		-- 			--   ...
		-- 			--   return vim_item
		-- 			-- end
		-- 		}),
		-- 	},
		-- })

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline({ "/", "?" }, {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = {
		-- 		{ name = "buffer" },
		-- 	},
		-- })
		--
		-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline(":", {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = cmp.config.sources({
		-- 		{ name = "path" },
		-- 	}, {
		-- 		{ name = "cmdline" },
		-- 	}),
		-- })

		-- Set up lspconfig.
		-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- require("lspconfig")["rust_analyzer"].setup({
		-- 	capabilities = capabilities,
		-- })
	end,
}
