$env.config.history = {
    file_format: "sqlite" # Required for isolation
    isolation: true       # Enables session-specific history (Up/Down keys)
    max_size: 10000
    sync_on_enter: true
}

