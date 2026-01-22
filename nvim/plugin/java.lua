if vim.g.did_load_java_configuration then
  return
end
vim.g.did_load_java_configuration = true

vim.lsp.enable('jdtls')

-- Traverse back the file system tree from the current path and create a test file, mimicking the tree traversal under the test path.
local create_test_file = function ()
  local root = vim.fs.root(0, 'pom.xml')
  local path = vim.api.nvim_buf_get_name(0)
  local filename = vim.fs.basename(path)
  local testname = vim.fn.fnamemodify(filename, ':r') .. 'Test' .. '.java'

  local src_pos, src_path = vim.iter(vim.fs.parents(path))
    :enumerate()
    :find(function(_, val) return vim.fs.basename(val) == 'src' end)

  if not src_pos then
    vim.notify("Project `src` not found.")
    return
  end

  local parts = vim.iter(vim.fs.parents(path))
    :take(src_pos - 2)  -- Stop before `src` skipping `main`
    :totable()

  if vim.iter(parts):any(function (k, _) return k == root end) then
    vim.notify("The `src` folder is outside the root: " .. root)
    return
  end

  local testdir = vim.iter(parts)
    :rev()
    :fold(vim.fs.joinpath(src_path, 'test'),
    function (acc, k, _)
      return vim.fs.joinpath(acc, vim.fs.basename(k))
    end)

  local test = vim.fs.joinpath(testdir, testname)

  vim.fn.mkdir(vim.fs.dirname(test), 'p')
  if vim.uv.fs_stat(test) then
    vim.notify("Testfile exists @ " .. test)
  else
    vim.notify("Writing file @ " .. test)
    vim.fn.writefile({}, test)
  end
end

vim.api.nvim_create_user_command('JavaNewTest', create_test_file, {})
