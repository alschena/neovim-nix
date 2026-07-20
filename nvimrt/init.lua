vim.loader.enable()

vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', ' ', '<Nop>')

vim.o.path = vim.o.path .. '**'
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.lazyredraw = true
vim.o.showmatch = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.spell = true
vim.o.spelllang = 'en'
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.foldenable = true
vim.o.history = 2000
vim.o.nrformats = 'bin,hex' -- 'octal'
vim.o.undofile = true
vim.o.autocomplete = false
vim.o.complete = 'o^12'
vim.o.completeopt = 'menuone,noselect,nearest,popup'
vim.o.breakindent = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.inccommand = 'split'
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.mouse = 'a'

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.cmd.filetype('plugin', 'indent', 'on')
vim.cmd.packadd('cfilter')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'switch to normal mode' })
vim.keymap.set('t', '<C-Esc>', '<Esc>', { desc = 'send Esc to terminal' })

vim.keymap.set('c', '%%', function()
  if vim.fn.getcmdtype() == ':' then
    return vim.fn.expand('%:h') .. '/'
  else
    return '%%'
  end
end, { expr = true, desc = "expand to current buffer's directory" })

vim.keymap.set('n', 'grs', vim.lsp.buf.workspace_symbol, {desc = 'load workspace/symbols to quickfix list' })
vim.keymap.set('n', 'grd', vim.lsp.buf.workspace_diagnostics, {desc = 'load workspace/diagnostics to quickfix list' })

vim.keymap.set('n', 'grl', vim.diagnostic.open_float, {desc = 'diagnostics floating window' })
vim.keymap.set('n', 'grd', vim.diagnostic.setloclist, {desc = 'load diagnostics to loclist' })
vim.keymap.set('n', 'grD', vim.diagnostic.setqflist, {desc = 'load diagnostics to quickfixlist' })

vim.api.nvim_create_user_command('Ldiagnostics', vim.diagnostic.setloclist, {})
vim.api.nvim_create_user_command('Cdiagnostics', vim.diagnostic.setqflist, {})
vim.api.nvim_create_user_command('ShowDiagnostic', vim.diagnostic.open_float, {})

vim.keymap.set('n', 'g~d', function() vim.diagnostics.enable(not vim.diagnostic.is_enabled()) end, {desc = 'toggle diagnostics' })
vim.keymap.set('n', 'g~s', function() vim.o.spell = not vim.o.spell end, {desc = 'toggle diagnostics' })

vim.keymap.set('n', '/', '/\\v', { desc = 'very magic search' })
vim.keymap.set('n', '?', '?\\v', { desc = 'very magic backward search' })
vim.keymap.set('v', '/', '/\\v%V', { desc = 'very magic search visual search' })
vim.keymap.set('v', '?', '?\\v%V', { desc = 'very magic backward visual search' })
vim.keymap.set('v', 's', ':s/\\v%V', { desc = 'very magic substitution in visual' })
vim.keymap.set('n', 's', '<Nop>', { desc = 'very magic default substitutions' })
vim.keymap.set('n', 'sb', ':%s/\\v', { desc = 'very magic buffer substitution' })
vim.keymap.set('n', 'sl', ':s/\\v', { desc = 'very magic line substitution' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'move [d]own half-page and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'move [u]p half-page and center' })
vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'move DOWN [f]ull-page and center' })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'move UP full-page and center' })

vim.lsp.config('*', {
  capabilities = {
    general = {
      positionEncodings = { 'uft-8' },
    },
  },
})

vim.lsp.enable({
  'ltex-ls',
  'luals',
  'nixd',
  'zls',
  'ty',
  'ruff',
})
