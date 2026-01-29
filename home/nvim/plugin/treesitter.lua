require('nvim-treesitter').setup {}

-- Enable treesitter features for installed parsers
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'nix', 'just', 'vim', 'bash', 'sh', 'lua', 'json', 'go', 'beancount', 'terraform', 'rust', 'javascript' },
  callback = function()
    -- Highlighting
    vim.treesitter.start()

    -- Folding
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldlevel = 99  -- Open all folds by default

    -- Indentation (experimental)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
