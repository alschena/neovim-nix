vim.loader.enable()
require('vim._core.ui2').enable()

vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', ' ', '<Nop>')

vim.o.path = vim.o.path .. '**'
vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = 'yes'
vim.o.lazyredraw = true
vim.o.laststatus = 1
vim.o.shortmess = ''
vim.o.showmatch = true
vim.o.belloff = ''
vim.o.visualbell = true
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
vim.o.wildmode = 'longest:full'
vim.o.winborder = 'single'
vim.o.pumborder = 'single'
vim.o.autocomplete = false
vim.o.complete = 'o^12'
vim.o.completeopt = 'menuone,noselect,nearest,popup'
vim.o.showbreak = '> '
vim.o.breakindentopt = 'sbr'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.inccommand = 'split'
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.mouse = 'a'

if vim.fn.executable('fd') then
  function _G.findfunc(cmdarg, cmdcomplete)
    local cmd = { 'fd', '--hidden' }
    if cmdarg ~= '' then
      table.insert(cmd, cmdarg)
    end
    return vim.fn.systemlist(cmd)
  end
  vim.o.findfunc = 'v:lua.findfunc'
end

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.cmd.filetype('plugin', 'indent', 'on')
vim.cmd.packadd('cfilter')

vim.keymap.set({ 'n' }, 'J', '<nop>', {} )
vim.keymap.set({ 'n' }, 'S', '<nop>', {} )
vim.keymap.set({ 'n' }, 'JJ', '<C-w>j', {} )
vim.keymap.set({ 'n' }, 'JK', '<C-w>k', {} )
vim.keymap.set({ 'n' }, 'JL', '<C-w>l', {} )
vim.keymap.set({ 'n' }, 'JH', '<C-w>h', {} )
vim.keymap.set({ 'n' }, 'JO', '<C-w>o', {} )
vim.keymap.set({ 'n' }, 'JS', vim.diagnostic.open_float, {} )

vim.keymap.set({ 'i', 'o' }, 'jk', '<Esc>', { desc = 'switch to normal mode' })
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'switch to normal mode' })
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

vim.keymap.set('n', 'grl', vim.diagnostic.setloclist, {desc = 'load diagnostics to loclist' })
vim.keymap.set('n', 'grq', vim.diagnostic.setqflist, {desc = 'load diagnostics to quickfixlist' })

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
