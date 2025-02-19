return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre" },
    cmd = { "ConformInfo" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          c = { "clang-formatter" },
          javascript = { { "prettierd", "prettier" } },
          lua = { "stylua" },
          php = { "pint" },
          python = { "isort", "black" },
          sh = { "shfmt" },
          sql = { "sqruff" },
          yaml = { "yamlfmt" },
        },

        format_on_save = false,
      })

      vim.keymap.set({ "n", "v" }, "<leader>p", function()
        conform.format({
          lsp_fallback = true,
          async = true,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
}
