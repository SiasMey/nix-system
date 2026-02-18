$env.config.history = {
    file_format: "sqlite" # Required for isolation
    isolation: true       # Enables session-specific history (Up/Down keys)
    max_size: 10000
    sync_on_enter: true
}

$env.config.keybindings = [
    {
        name: menu_down
        modifier: none
        keycode: down
        mode: [vi_normal]
        event: { send: menudown }
    }
    {
        name: menu_down_alt
        modifier: control
        keycode: char_h
        mode: [vi_normal]
        event: { send: menudown }
    }
    # Move up in menu with Ctrl+p or k
    {
        name: menu_up
        modifier: none
        keycode: up
        mode: [vi_normal]
        event: { send: menuup }
    }
    {
        name: menu_up_alt
        modifier: control
        keycode: char_l
        mode: [vi_normal]
        event: { send: menuup }
    }
    # Select item with Enter
    {
        name: menu_select
        modifier: none
        keycode: enter
        mode: [vi_normal]
        event: { send: enter }
    }
    {
        name: menu_select_alt
        modifier: control
        keycode: char_y
        mode: [vi_normal]
        event: { send: enter }
    }
]

