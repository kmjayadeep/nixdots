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
    settings = {
        python = {
            analysis = {
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
