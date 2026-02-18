$env.config.history = {
    file_format: "sqlite" # Required for isolation
    isolation: true       # Enables session-specific history (Up/Down keys)
    max_size: 10000
    sync_on_enter: true
}

$env.config.keybindings ++= [
  {
      modifier: control
      keycode: char_l
      mode: [emacs, vi_normal, vi_insert]
      event: null
  }
  {
      modifier: control
      keycode: char_h
      mode: [emacs, vi_normal, vi_insert]
      event: null
  }
  {
      modifier: control
      keycode: char_y
      mode: [emacs, vi_normal, vi_insert]
      event: null
  }
  {
      modifier: control
      keycode: char_p
      mode: [emacs, vi_normal, vi_insert]
      event: null
  }
  {
      modifier: control
      keycode: char_n
      mode: [emacs, vi_normal, vi_insert]
      event: null
  }
  {
      modifier: control
      keycode: char_l
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menuup }
  }
  {
      modifier: control
      keycode: char_h
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menudown }
  }
  {
      modifier: control
      keycode: char_y
      mode: [emacs, vi_normal, vi_insert]
      event: { send: enter }
  }
  {
      modifier: control
      keycode: char_n
      mode: [emacs, vi_normal, vi_insert]
      event: { send: escape }
  }
]

