if vim.g.did_load_treesitter_plugin then
  return
end
vim.g.did_load_treesitter_plugin = true
vim.g.skip_ts_context_comment_string_module = true

-- Remove this plugin when the Neovim TreeSitter API covers this functionality
require('treesitter-modules').setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<M-o>',
      node_incremental = '<M-o>',
      scope_incremental = '<M-p>',
      node_decremental = '<M-i>',
    }
  }
}

require('nvim-treesitter-textobjects').setup {
  select = {
    -- Automatically jump forward to textobject, similar to targets.vim
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V',  -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
  },
  move = { set_jumps = true, },
}

local select_keymaps = function(key, query, group, desc)
  vim.keymap.set({ 'x', 'o' }, key, function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, group)
  end, {desc = desc})
end

local select_textobject_keymaps = function(key, query)
  select_keymaps(key, query, "textobjects", query)
end

select_textobject_keymaps("af", "@function.outer")
select_textobject_keymaps("if", "@function.inner")
select_textobject_keymaps("ac", "@class.outer")
select_textobject_keymaps("ic", "@class.inner")
select_textobject_keymaps("aC", "@call.outer")
select_textobject_keymaps("iC", "@call.inner")
select_textobject_keymaps("a#", "@comment.outer")
select_textobject_keymaps("i#", "@comment.inner")
select_textobject_keymaps("ai", "@conditional.outer")
select_textobject_keymaps("ii", "@conditional.inner")
select_textobject_keymaps("al", "@loop.outer")
select_textobject_keymaps("il", "@loop.inner")
select_textobject_keymaps("aP", "@parameter.outer")
select_textobject_keymaps("iP", "@parameter.inner")

select_keymaps("as", "@local.scope", "locals")

-- Swap keybindings
vim.keymap.set("n", ",F", "<Nop>", { desc = "+Flip" })
vim.keymap.set("n", ",Fn", function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end, { desc = "Parameter next" })
vim.keymap.set("n", ",Fp", function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end, { desc = "Parameter previous" })

-- Move keybindings
-- keymaps

local goto_next_start = require("nvim-treesitter-textobjects.move").goto_next_start
local goto_next_end = require("nvim-treesitter-textobjects.move").goto_next_end
local goto_previous_start = require("nvim-treesitter-textobjects.move").goto_previous_start
local goto_previous_end = require("nvim-treesitter-textobjects.move").goto_previous_end

-- Go to either the start or the end, whichever is closer.
-- Use if you want more granular movements

local goto_next = require("nvim-treesitter-textobjects.move").goto_next
local goto_previous = require("nvim-treesitter-textobjects.move").goto_previous

local goto_keymaps = function (key, query, group, movement)
  vim.keymap.set({ "n", "x", "o" }, key, function()
    movement(query, group)
  end)
end

goto_keymaps("]f", "@function.outer", "textobjects", goto_next_start)
goto_keymaps("]]", "@class.outer", "textobjects", goto_next_start)
goto_keymaps("]o", { "@loop.inner", "@loop.outer" }, "textobjects", goto_next_start)
goto_keymaps("]S", "@local.scope", "locals", goto_next_start)
goto_keymaps("]z", "@fold", "folds", goto_next_start)
goto_keymaps("]F", "@function.outer", "textobjects", goto_next_end)
goto_keymaps("][", "@class.outer", "textobjects", goto_next_end)
goto_keymaps("[f", "@function.outer", "textobjects", goto_previous_start)
goto_keymaps("[[", "@class.outer", "textobjects", goto_previous_start)
goto_keymaps("[F", "@function.outer", "textobjects", goto_previous_end)
goto_keymaps("[]", "@class.outer", "textobjects", goto_previous_end)
goto_keymaps("]i", "@conditional.outer", "textobjects", goto_next)
goto_keymaps("[i", "@conditional.outer", "textobjects", goto_previous)

-- Make the movements repeatable via ;
local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

-- Repeat movement with ;
-- ensure ; goes forward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

require('treesitter-context').setup {
  max_lines = 3,
}

require('ts_context_commentstring').setup()

-- Tree-sitter based folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
