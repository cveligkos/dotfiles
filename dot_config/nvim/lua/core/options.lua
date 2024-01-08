local opt = vim.opt

opt.completeopt = "menu,menuone,noselect"

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.wrap = true

opt.cursorline = true
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.splitright = true
opt.splitbelow = true

opt.scrolloff = 10

opt.mouse = nil

opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.smartcase = true
opt.ignorecase = true


