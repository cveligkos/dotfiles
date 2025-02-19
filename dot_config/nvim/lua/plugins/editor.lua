return {
  -- "numToStr/Comment.nvim" {{{
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  -- }}}

  -- "lewis6991/gitsigns.nvim" {{{
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  -- }}}

  -- "folke/trouble.nvim" {{{
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- }}}

  -- "folke/todo-comments.nvim" {{{
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  -- }}}

  -- "hiphish/rainbow-delimiters.nvim" {{{
  {
    "hiphish/rainbow-delimiters.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      require("rainbow-delimiters.setup")({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },
  -- }}}

  -- "folke/flash.nvim" {{{
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  -- }}}

  -- "folke/which-key.nvim" {{{
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  -- }}}

  -- "nvim-telescope/telescope.nvim" {{{
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")

      local keymap = vim.keymap

      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
      keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find w/ grep in cwd" })
      keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find open buffers" })
      keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Fuzzy find help" })
    end,
  },
  -- }}}

  -- "nvim-neo-tree/neo-tree.nvim" {{{
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      { "<leader>e", ":Neotree toggle<CR>", mode = "n", desc = "Toggle Neotree", noremap = true },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,

          window = {

            mappings = {
              ["h"] = { "close_node" },
              ["l"] = { "open" },
            },
          },
        },
      })
    end,
  },
  -- }}}

  -- "stevearc/oil.nvim" {{{
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  -- }}}

  --   { "tpope/vim-fugitive" },

  -- "ray-x/sad.nvim" {{{
  {
    "ray-x/sad.nvim",
    dependencies = {
      {
        "ray-x/guihua.lua",
        build = "cd lua/fzy && make",
        opts = {},
      },
    },
    opts = {
      debug = false,
      diff = "delta",
    },
  },
  -- }}}

  -- "nvim-pack/nvim-spectre" {{{
  {
    "nvim-pack/nvim-spectre",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>r", ":Spectre toggle<CR>", mode = "n", desc = "Toggle Spectre", noremap = true },
    },
    opts = {},
  },
  -- }}}

  { "ledger/vim-ledger" },
  { "gpanders/nvim-parinfer" },
  { "sheerun/vim-polyglot" },
  { "Fymyte/rasi.vim", ft = "rasi" },
  { "imsnif/kdl.vim" },
  { "fladson/vim-kitty" },
  -- { "nathangrigg/vim-beancount" },
  -- { "terrastruct/d2-vim" },
  -- { "elkowar/yuck.vim" },
}
