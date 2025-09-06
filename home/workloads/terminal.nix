{...}: {
  home.file = {
    ".config/ghostty/config".source = ../dotfiles/ghostty/config;
    # ghostty has to be installed via homebrew on mac
  };

  home.file = {
    ".config/alacritty/themes/theme.toml".source = ../dotfiles/alacritty/solarized_light.toml;
  };

  programs.alacritty = {
    enable = false;
    settings = {
      env = {
        TERM = "xterm-kitty";
      };
      general = {
        import = ["~/.config/alacritty/themes/theme.toml"];
        live_config_reload = true;
      };
      window = {
        decorations = "buttonless";
        startup_mode = "Fullscreen";
        option_as_alt = "Both";
        dynamic_padding = true;
        padding = {
          x = 0;
          y = 0;
        };
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Italic";
        };
        size = 16;
        offset = {
          x = 0;
          y = 0;
        };
        glyph_offset = {
          x = 0;
          y = 0;
        };
      };
      keyboard.bindings = [
        {
          key = "F";
          mods = "Control|Command";
          action = "ToggleFullscreen";
        }
        {
          key = "Q";
          mods = "Command";
          action = "ReceiveChar";
        }
        {
          key = "N";
          mods = "Command";
          action = "ReceiveChar";
        }
        {
          key = "W";
          mods = "Command";
          action = "ReceiveChar";
        }

        # scrollback
        {
          key = "PageUp";
          mods = "Shift";
          mode = "~Alt";
          action = "ReceiveChar";
        }
        {
          key = "PageDown";
          mods = "Shift";
          mode = "~Alt";
          action = "ReceiveChar";
        }
        {
          key = "Home";
          mods = "Shift";
          mode = "~Alt";
          action = "ReceiveChar";
        }
        {
          key = "End";
          mods = "Shift";
          mode = "~Alt";
          action = "ReceiveChar";
        }
        {
          key = "K";
          mods = "Command";
          mode = "~Vi|Search";
          action = "ReceiveChar";
        }

        # searching
        {
          key = "F";
          mods = "Control|Shift";
          mode = "~Search";
          action = "ReceiveChar";
        }
        {
          key = "F";
          mods = "Command";
          mode = "~Search";
          action = "ReceiveChar";
        }
        {
          key = "B";
          mods = "Control|Shift";
          mode = "~Search";
          action = "ReceiveChar";
        }
        {
          key = "B";
          mods = "Command";
          mode = "~Search";
          action = "ReceiveChar";
        }

        # copy/paste
        {
          key = "Paste";
          action = "ReceiveChar";
        }
        {
          key = "Copy";
          action = "ReceiveChar";
        }
        {
          key = "V";
          mods = "Control|Shift";
          mode = "~Vi";
          action = "ReceiveChar";
        }
        {
          key = "V";
          mods = "Command";
          action = "Paste";
        }

        {
          key = "C";
          mods = "Control|Shift";
          action = "ReceiveChar";
        }
        {
          key = "C";
          mods = "Command";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Command|Shift";
          mode = "~Vi";
          action = "ReceiveChar";
        }
        {
          key = "C";
          mods = "Control|Shift";
          mode = "~Vi|~Search";
          action = "ReceiveChar";
        }
      ];
    };
  };
}
