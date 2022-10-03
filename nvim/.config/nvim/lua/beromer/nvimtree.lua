require("nvim-tree").setup({
    sort_by = "case_sensitive",
    filters = {
        dotfiles = true,
    },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    open_on_tab = true,
    hijack_cursor = true,
    update_cwd = true,
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 30,
        hide_root_folder = false,
        side = "left",
        adaptive_size = true,
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>" }, action = "edit" },
                { key = "h", action = "close_node" },
                { key = "v", action = "vsplit" },
            },
        },
        number = true,
        relativenumber = true,
    },
    renderer = {indent_markers = { enable = true,},},
})
