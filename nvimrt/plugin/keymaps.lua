if vim.g.did_load_keymaps_plugin then
  return
end
vim.g.did_load_keymaps_plugin = true

local api = vim.api
local fn = vim.fn
local keymap = vim.keymap
local diagnostic = vim.diagnostic

-- Remap Esc to switch to normal mode and Ctrl-Esc to pass Esc to terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'switch to normal mode' })
keymap.set('t', '<C-Esc>', '<Esc>', { desc = 'send Esc to terminal' })

-- Shortcut for expanding to current buffer's directory in command mode
keymap.set('c', '%%', function()
  if fn.getcmdtype() == ':' then
    return fn.expand('%:h') .. '/'
  else
    return '%%'
  end
end, { expr = true, desc = "expand to current buffer's directory" })

local severity = diagnostic.severity

local diagnostic_floating_window = function()
  local _, winid = diagnostic.open_float(nil, { scope = 'line' })
  if not winid then
    vim.notify('no diagnostics found', vim.log.levels.INFO)
    return
  end
  vim.api.nvim_win_set_config(winid or 0, { focusable = true })
end
keymap.set('n', ',df', diagnostic_floating_window, { silent = true, desc = 'diagnostics floating window' })

keymap.set('n', '[e', function()
  diagnostic.jump {
    count = -1,
    severity = severity.ERROR,
  }
end, { silent = true, desc = 'previous [e]rror diagnostic' })
keymap.set('n', ']e', function()
  diagnostic.jump {
    count = 1,
    severity = severity.ERROR,
  }
end, { silent = true, desc = 'next [e]rror diagnostic' })
keymap.set('n', '[w', function()
  diagnostic.jump {
    count = -1,
    severity = severity.WARN,
  }
end, { silent = true, desc = 'previous [w]arning diagnostic' })
keymap.set('n', ']w', function()
  diagnostic.jump {
    count = 1,
    severity = severity.WARN,
  }
end, { silent = true, desc = 'next [w]arning diagnostic' })
keymap.set('n', '[h', function()
  diagnostic.jump {
    count = -1,
    severity = severity.HINT,
  }
end, { silent = true, desc = 'previous [h]int diagnostic' })
keymap.set('n', ']h', function()
  diagnostic.jump {
    count = 1,
    severity = severity.HINT,
  }
end, { silent = true, desc = 'next [h]int diagnostic' })

local function buf_toggle_diagnostics()
  local filter = { bufnr = api.nvim_get_current_buf() }
  diagnostic.enable(not diagnostic.is_enabled(filter), filter)
end

keymap.set('n', ',~d', buf_toggle_diagnostics, { desc = "[t]oggle buf [d]iagnostics" } )
keymap.set('n', ',dl', vim.diagnostic.setloclist, { desc = "Set buffers diagnostics to location list" })
keymap.set('n', ',dk', vim.diagnostic.setqflist, { desc = "Set all diagnostics to quickfix list" })

local function toggle_spell_check()
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.opt.spell = not (vim.opt.spell:get())
end

keymap.set({'n', 'v'}, ', ', 'gc', { remap = true, desc = 'comment' })

keymap.set('n', ',~s', toggle_spell_check, { silent = true, desc = 'Toggle spell' })
keymap.set('n', ',x', '<Nop>', { silent = true, desc = '+Fix' })
keymap.set('n', ',xs', 'z=', { silent = true, desc = 'Fix syntax' })
keymap.set('n', ',~z', 'zi', { silent = true, desc = 'Toggle folds' })

keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'move [d]own half-page and center' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'move [u]p half-page and center' })
keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'move DOWN [f]ull-page and center' })
keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'move UP full-page and center' })

--- Disabled keymaps [enable at your own risk]

-- Automatic management of search highlight
-- XXX: This is not so nice if you use j/k for navigation
-- (you should be using <C-d>/<C-u> and relative line numbers instead ;)
--
-- local auto_hlsearch_namespace = vim.api.nvim_create_namespace('auto_hlsearch')
-- vim.on_key(function(char)
--   if vim.fn.mode() == 'n' then
--     vim.opt.hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
--   end
-- end, auto_hlsearch_namespace)
