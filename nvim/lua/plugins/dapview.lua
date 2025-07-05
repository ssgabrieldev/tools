return {
  "igorlfs/nvim-dap-view",
  opts = {
    winbar = {
      sections = {
        "watches",
        "scopes",
        "exceptions",
        "breakpoints",
        "threads",
        "repl",
        "console"
      },
      default_section = "repl",
      controls = {
        enabled = true
      },
    }
  }
}
