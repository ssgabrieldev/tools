return {
  input = function(label, default)
    local co = coroutine.running()
    assert(co, "must be running under a coroutine")
    vim.ui.input({ prompt = label, default = default }, function(str)
      coroutine.resume(co, str)
    end)
    local input = coroutine.yield()
    return input
  end
}
