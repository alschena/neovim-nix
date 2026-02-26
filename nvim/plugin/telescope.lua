if vim.g.did_load_telescope_plugin then
  return
end
vim.g.did_load_telescope_plugin = true

local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

local layout_config = {
  vertical = {
    width = function(_, max_columns)
      return math.floor(max_columns * 0.99)
    end,
    height = function(_, _, max_lines)
      return math.floor(max_lines * 0.99)
    end,
    prompt_position = 'bottom',
    preview_cutoff = 0,
  },
}

-- Fall back to find_files if not in a git repo
local project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

---@param picker function the telescope picker to use
local function grep_current_file_type(picker)
  local current_file_ext = vim.fn.expand('%:e')
  local additional_vimgrep_arguments = {}
  if current_file_ext ~= '' then
    additional_vimgrep_arguments = {
      '--type',
      current_file_ext,
    }
  end
  local conf = require('telescope.config').values
  picker {
    vimgrep_arguments = vim.iter({
      conf.vimgrep_arguments,
      additional_vimgrep_arguments,
    }):flatten(),
  }
end

--- Grep the string under the cursor, filtering for the current file type
local function grep_string_current_file_type()
  grep_current_file_type(builtin.grep_string)
end

--- Live grep, filtering for the current file type
local function live_grep_current_file_type()
  grep_current_file_type(builtin.live_grep)
end

--- Like live_grep, but fuzzy (and slower)
local function fuzzy_grep(opts)
  opts = vim.tbl_extend('error', opts or {}, { search = '', prompt_title = 'Fuzzy grep' })
  builtin.grep_string(opts)
end

local function fuzzy_grep_current_file_type()
  grep_current_file_type(fuzzy_grep)
end

vim.keymap.set('n', '<Space>', '<Nop>', { desc = '+Telescope' })
vim.keymap.set('n', '<Space>f', function() builtin.find_files() end, { desc = 'find files' })
vim.keymap.set('n', '<Space>t', '<cmd>Telescope<CR>', { desc = 'pickers' })
vim.keymap.set('n', '<Space>o', builtin.oldfiles, { desc = 'old files' })
vim.keymap.set('n', '<Space>/', builtin.live_grep, { desc = 'live grep' })
vim.keymap.set('n', '<Space>?', fuzzy_grep, { desc = 'fuzzy grep' })
vim.keymap.set('n', '<Space>e', fuzzy_grep_current_file_type, { desc = 'fuzzy grep filetype' })
vim.keymap.set('n', '<Space>E', live_grep_current_file_type, { desc = 'live grep filetype' })
vim.keymap.set('n', '<Space>*', builtin.grep_string, { desc = 'grep current string' })
vim.keymap.set('n', '<Space>g', project_files, { desc = 'project files' })
vim.keymap.set('n', '<Space>q', builtin.quickfix, { desc = 'quickfix list' })
vim.keymap.set('n', '<Space>:', builtin.command_history, { desc = 'command history' })
vim.keymap.set('n', '<Space>l', builtin.loclist, { desc = 'loclist' })
vim.keymap.set('n', '<Space>"', builtin.registers, { desc = 'registers' })
vim.keymap.set('n', "<Space>'", builtin.marks, { desc = 'marks' })
vim.keymap.set('n', '<Space>b', builtin.buffers, { desc = 'buffers' })
vim.keymap.set('n', '<Space>S', builtin.lsp_document_symbols, { desc = 'lsp document symbols' })
vim.keymap.set('n', '<Space>d', builtin.diagnostics, { desc = 'diagnostics' })
vim.keymap.set('n', '<Space>h', builtin.help_tags, { desc = 'help' })
vim.keymap.set('n', '<Space>m', builtin.git_status, { desc = 'modified (git status)' })
vim.keymap.set( 'n', '<Space>s', builtin.lsp_dynamic_workspace_symbols, { desc = 'lsp dynamic workspace symbols' })

telescope.setup {
  defaults = {
    path_display = {
      'truncate',
    },
    layout_strategy = 'vertical',
    layout_config = layout_config,
    mappings = {
      i = {
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-l>'] = actions.send_to_loclist,
        -- ['<esc>'] = actions.close,
        ['<C-n>'] = actions.cycle_previewers_next,
        ['<C-p>'] = actions.cycle_previewers_prev,
      },
      n = {
        q = actions.close,
      },
    },
    preview = {
      treesitter = true,
    },
    history = {
      path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
      limit = 1000,
    },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

telescope.load_extension('fzy_native')
-- telescope.load_extension('smart_history')
