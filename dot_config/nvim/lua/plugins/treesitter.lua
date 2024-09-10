return {
  -- "nvim-treesitter/nvim-treesitter" {{{
  {
    "nvim-treesitter/nvim-treesitter",
    -- dependencies = { "windwp/nvim-ts-autotag" },
    version = nil,
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = false,
        sync_install = false,
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
          disable = function(lang, buf)
            local max_filesize = 1024 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        autotag = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  -- }}}
}
