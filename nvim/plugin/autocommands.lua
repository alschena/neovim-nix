if vim.g.did_load_autocommands_plugin then
  return
end
vim.g.did_load_autocommands_plugin = true

local api = vim.api

local tempdirgroup = api.nvim_create_augroup('tempdir', { clear = true })

-- Do not set undofile for files in /tmp
api.nvim_create_autocmd('BufWritePre', {
  pattern = '/tmp/*',
  group = tempdirgroup,
  callback = function()
    vim.cmd.setlocal('noundofile')
  end,
})

-- Disable spell checking in terminal buffers
local nospell_group = api.nvim_create_augroup('nospell', { clear = true })
api.nvim_create_autocmd('TermOpen', {
  group = nospell_group,
  callback = function()
    vim.wo[0].spell = false
  end,
})

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  local buf, _ = vim.lsp.util.preview_location(result[1])
  if buf then
    local cur_buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].filetype = vim.bo[cur_buf].filetype
  end
end

local function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local function peek_type_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, preview_location_callback)
end

--- Don't create a comment string when hitting <Enter> on a comment line
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('DisableNewLineAutoCommentString', {}),
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Attach plugins
    require('nvim-navic').attach(client, bufnr)

    vim.cmd.setlocal('signcolumn=yes')
    vim.bo[bufnr].bufhidden = 'hide'

    local function desc(description)
      return { silent = true, buffer = bufnr, desc = description }
    end
    vim.keymap.set('n', ',J', vim.lsp.buf.declaration, desc('lsp [g]o to [D]eclaration'))
    vim.keymap.set('n', ',j', vim.lsp.buf.definition, desc('lsp [g]o to [d]efinition'))
    vim.keymap.set('n', ',y', vim.lsp.buf.type_definition, desc('lsp [g]o to [t]ype definition'))
    vim.keymap.set('n', ',k', vim.lsp.buf.hover, desc('[lsp] hover'))
    vim.keymap.set('n', ',pd', peek_definition, desc('lsp [p]eek [d]efinition'))
    vim.keymap.set('n', ',pt', peek_type_definition, desc('lsp [p]eek [t]ype definition'))
    vim.keymap.set('n', ',i', vim.lsp.buf.implementation, desc('lsp [g]o to [i]mplementation'))
    vim.keymap.set('n', ',K', vim.lsp.buf.signature_help, desc('[lsp] signature help'))
    vim.keymap.set('n', ',wa', vim.lsp.buf.add_workspace_folder, desc('lsp add [w]orksp[a]ce folder'))
    vim.keymap.set('n', ',wr', vim.lsp.buf.remove_workspace_folder, desc('lsp [w]orkspace folder [r]emove'))
    vim.keymap.set('n', ',wl', function() vim.print(vim.lsp.buf.list_workspace_folders()) end, desc('[lsp] [w]orkspace folders [l]ist'))
    vim.keymap.set('n', ',r', vim.lsp.buf.rename, desc('lsp [r]e[n]ame'))
    vim.keymap.set('n', ',S', vim.lsp.buf.workspace_symbol, desc('lsp [w]orkspace [s]ymbol'))
    vim.keymap.set('n', ',s', vim.lsp.buf.document_symbol, desc('lsp [dd]ocument symbol'))
    vim.keymap.set('n', ',xa', vim.lsp.buf.code_action, desc('[lsp] code action'))
    vim.keymap.set('n', ',xl', vim.lsp.codelens.run, desc('[lsp] run code lens'))
    vim.keymap.set('n', ',f', vim.lsp.buf.references, desc('lsp [g]et [r]eferences'))
    vim.keymap.set('n', ',=', function()
      vim.lsp.buf.format { async = true }
    end, desc('[lsp] [f]ormat buffer'))

    if not client then
      return
    end

    if client.server_capabilities.inlayHintProvider then
      local toggle_inline_hints = function()
        local current_setting = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
        vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
      end
      vim.keymap.set('n', ',~h', toggle_inline_hints , desc('lsp [t]oggle inlay [h]ints'))
    end

    if client.server_capabilities.codeLensProvider then
      vim.lsp.codelens.enable(true)
    end

    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

  end,
})
