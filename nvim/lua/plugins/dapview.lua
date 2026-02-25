local function build_title_fn(title, icon)
    return function (width)
        if width <= 118 then
            return icon
        end

        return title
    end
end

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
            base_sections = {
                breakpoints = { label = build_title_fn("Breakpoints", ""), keymap = "B" },
                scopes = { label = build_title_fn("Scopes", "󰭳"), keymap = "S" },
                exceptions = { label = build_title_fn("Exceptions", "󱈸"), keymap = "E" },
                watches = { label = build_title_fn("Watches", "󰈈"), keymap = "W" },
                threads = { label = build_title_fn("Threads", ""), keymap = "T" },
                repl = { label = build_title_fn("REPL", ""), keymap = "R" },
                sessions = { label = build_title_fn("Sessions", "󰭳"), keymap = "K" },
                console = { label = build_title_fn("Console", ""), keymap = "C" },
            },
        }
    }
}
