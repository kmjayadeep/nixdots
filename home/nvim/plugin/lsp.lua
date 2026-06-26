local on_attach = function(_, bufnr)

  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('<leader>rn', vim.lsp.buf.rename)
  bufmap('<leader>ca', vim.lsp.buf.code_action)

  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)

  bufmap('gr', require('telescope.builtin').lsp_references)
  bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
  bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  bufmap('K', vim.lsp.buf.hover)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local function executable(path)
  return path and vim.fn.executable(path) == 1
end

local function python_path(root_dir)
  root_dir = root_dir or vim.fn.getcwd()

  -- Prefer the active shell virtualenv, if Neovim was launched from one.
  if executable(vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. '/bin/python')) then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  end

  -- uv creates a project-local .venv by default. Point pyright at it so
  -- packages added with `uv add` are available for import resolution and
  -- auto-import completions.
  for _, venv in ipairs({ '.venv', 'venv', 'env' }) do
    local path = root_dir .. '/' .. venv .. '/bin/python'
    if executable(path) then
      return path
    end
  end

  local python3 = vim.fn.exepath('python3')
  if python3 ~= '' then
    return python3
  end

  local python = vim.fn.exepath('python')
  if python ~= '' then
    return python
  end

  return 'python'
end

-- Golang LS
vim.lsp.config.gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Beancount LS  
vim.lsp.config.beancount = {
    cmd = { 'beancount-language-server' },
    filetypes = { 'beancount' },
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        journal_file = "/home/jayadeep/private/psuite/beancount/journal.beancount",
    },
}

-- Rust LS
vim.lsp.config.rust_analyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = false,
            }
        }
    }
}

-- Python LS
vim.lsp.config.pyright = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'uv.lock', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
    on_attach = on_attach,
    capabilities = capabilities,
    before_init = function(_, config)
        config.settings.python.pythonPath = python_path(config.root_dir)
    end,
    settings = {
        python = {
            -- Default to uv's project-local virtualenv. before_init fills in
            -- the absolute interpreter path per workspace.
            venvPath = '.',
            venv = '.venv',
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
                useLibraryCodeForTypes = true,
            },
        },
    },
}

-- Python linting and formatting
vim.lsp.config.ruff = {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', 'uv.lock', '.git' },
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
}

-- Enable all configured LSP servers
vim.lsp.enable({'gopls', 'beancount', 'rust_analyzer', 'pyright', 'ruff'})
