--  function lsp_keybinds(client, bufnr)
-- 	local opts = { noremap = true, silent = true, buffer = bufnr }
--
-- 	vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
-- 	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- 	vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
-- 	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- 	vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
-- 	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
-- 	vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
-- 	vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
-- 	vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
-- 	vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
-- 	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
-- 	vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
-- end

return {
  -- "neovim/nvim-lspconfig" {{{
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
  },
  -- }}}

  -- "williamboman/mason.nvim" {{{
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mason = require("mason")
      local mason_tool_installer = require("mason-tool-installer")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local lspconfig = require("lspconfig")

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      }

      local border_handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      }
      local handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            handlers = border_handlers,
          })
        end,

        -- ["svelte"] = function()
        -- 	lspconfig.svelte.setup({
        -- 		capabilities = capabilities,
        -- 		on_attach = function(client, bufnr)
        -- 			on_attach(client, bufnr)
        --
        -- 			vim.api.nvim_create_autocmd("BufWritePost", {
        -- 				pattern = { "*.js", "*.ts" },
        -- 				callback = function(ctx)
        -- 					if client.name == "svelte" then
        -- 						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        -- 					end
        -- 				end,
        -- 			})
        -- 		end,
        -- 	})
        -- end,

        ["emmet_ls"] = function()
          lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            handlers = border_handlers,
            filetypes = {
              "html",
              "typescriptreact",
              "javascriptreact",
              "css",
              "sass",
              "scss",
              "less",
              "svelte",
            },
          })
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            handlers = border_handlers,
            settings = { -- custom settings for lua
              Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  -- make language server aware of runtime files
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                  },
                },
              },
            },
          })
        end,

        -- Next, you can provide targeted overrides for specific servers.
        -- ["rust_analyzer"] = function()
        -- 	-- require("rust-tools").setup({})
        -- end,
      }

      mason.setup({
        ui = {
          border = "rounded",
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {
          -- language servers
          "lua_ls",
          "rust_analyzer",
          "intelephense",
          -- "phpactor",
          "clangd",
          -- "biome",
          -- "jsonls",
          "gopls",
          "bashls",
          "cssls",
          "eslint",
          -- "graphql",
          "html",
          "jsonls",
          -- "prismals",
          "tailwindcss",
          "ts_ls",
          "pyright",
          "biome",
        },

        handlers = handlers,
      })

      mason_tool_installer.setup({
        ensure_installed = {
          -- formatters
          "stylua",
          "prettierd",
          "isort",
          "black",
          "sqlfmt",
          "clang-format",
          "shfmt",

          --linters
          "eslint_d",
          "selene",
          "golangci-lint",
          "sqlfluff",
          "shellcheck",
        },
      })

      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
  },
  -- }}}

  -- "ray-x/lsp_signature.nvim" {{{
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({})
    end,
  },
  -- }}}

  -- "nvimdev/lspsaga.nvim" {{{
  {
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
        border = "rounded",
      })
    end,
  },
  -- }}}
}
