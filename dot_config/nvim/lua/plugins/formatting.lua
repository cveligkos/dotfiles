return {
  -- "stevearc/conform.nvim" {{{
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
          sql = { "sqlfmt" },
          yaml = { "yamlfmt" },
        },

        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })

      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
  -- }}}
}
