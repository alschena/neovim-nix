if vim.g.did_load_commands_plugin then
  return
end
vim.g.did_load_commands_plugin = true

vim.api.nvim_create_user_command('Comment', '<line1>,<line2> norm gcc', {range = true})
