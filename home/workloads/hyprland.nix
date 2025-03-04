{pkgs, ...}: {
  home.packages = [
    pkgs.hyprshot
    pkgs.hyprpicker
  ];

  programs.waybar = {
    enable = true;
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "loginctl lock-session";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
          shadow_passes = 2;
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=DP-1,2560x1440@144,auto,auto

      $terminal = ghostty
      $fileManager = dolphin
      $menu = rofi -show drun -show-icons
      $focus-or-start = ~/.config/hypr/focus-or-start.sh

      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24
      general {
          gaps_in = 5
          gaps_out = 20

          border_size = 2

          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          resize_on_border = false

          allow_tearing = false

          layout = master
      }

      decoration {
          rounding = 5

          active_opacity = 1.0
          inactive_opacity = 1.0

          shadow {
              enabled = true
              range = 4
              render_power = 3
              color = rgba(1a1a1aee)
          }

          blur {
              enabled = true
              size = 3
              passes = 1

              vibrancy = 0.1696
          }
      }

      animations {
          enabled = yes, please :)

          bezier = easeOutQuint,0.23,1,0.32,1
          bezier = easeInOutCubic,0.65,0.05,0.36,1
          bezier = linear,0,0,1,1
          bezier = almostLinear,0.5,0.5,0.75,1.0
          bezier = quick,0.15,0,0.1,1

          animation = global, 1, 10, default
          animation = border, 1, 5.39, easeOutQuint
          animation = windows, 1, 4.79, easeOutQuint
          animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
          animation = windowsOut, 1, 1.49, linear, popin 87%
          animation = fadeIn, 1, 1.73, almostLinear
          animation = fadeOut, 1, 1.46, almostLinear
          animation = fade, 1, 3.03, quick
          animation = layers, 1, 3.81, easeOutQuint
          animation = layersIn, 1, 4, easeOutQuint, fade
          animation = layersOut, 1, 1.5, linear, fade
          animation = fadeLayersIn, 1, 1.79, almostLinear
          animation = fadeLayersOut, 1, 1.39, almostLinear
          animation = workspaces, 1, 1.94, almostLinear, fade
          animation = workspacesIn, 1, 1.21, almostLinear, fade
          animation = workspacesOut, 1, 1.94, almostLinear, fade
      }

      dwindle {
          pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # You probably want this
      }

      master {
          new_status = master
      }

      misc {
          force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
      }


      #############
      ### INPUT ###
      #############

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 0

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

          touchpad {
              natural_scroll = false
          }
      }

      gestures {
          workspace_swipe = false
      }

      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }


      ###################
      ### KEYBINDINGS ###
      ###################

      $mainMod = SUPER # Sets "Windows" key as main modifier
      $hyper = SUPER CTRL ALT SHIFT

      bind = $mainMod, return, exec, $terminal
      bind = $mainMod, x, killactive,
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, space, exec, $menu
      bind = $mainMod, F, exec, $fileManager
      bind = $mainMod SHIFT, E , exit,

      # bind = $hyper, N, exec, $focus-or-start alacritty Alacritty
      bind = $hyper, N, exec, $focus-or-start ghostty com.mitchellh.ghostty
      # bind = $hyper, E, exec, $focus-or-start firefox firefox
      bind = $hyper, E, exec, $focus-or-start zen zen
      bind = $hyper, I, exec, $focus-or-start webcord WebCord
      bind = $hyper, M, exec, $focus-or-start steam steam
      bind = $hyper, J, exec, $focus-or-start lutris net.lutris.Lutris
      bind = $mainMod CTRL, f, fullscreen
      bind = $mainMod CTRL, s, layoutmsg, swapwithmaster auto

      bind = $mainMod SHIFT, s, exec, hyprshot --freeze -m region
      bind = $mainMod SHIFT, w, exec, hyprshot --freeze -m window

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################


      # Example windowrule v2
      windowrulev2 = workspace 1,class:^(kitty)$,title:^(kitty)$
      windowrulev2 = workspace 1,class:^(Alacritty)$,title:^(Alacritty)$
      windowrulev2 = workspace 1,class:^(com.mitchellh.ghostty)$
      windowrulev2 = workspace 2,class:^(firefox)$
      windowrulev2 = workspace 2,class:^(zen-beta)$
      windowrulev2 = workspace 2,class:^(zen)$
      windowrulev2 = workspace 3,class:^(discord)$
      windowrulev2 = workspace 3,class:^(WebCord)$
      windowrulev2 = workspace 5,class:^(steam)$
      windowrulev2 = workspace 6,class:^(net.lutris.Lutris)$

      # Ignore maximize requests from apps. You'll probably like this.
      windowrulev2 = suppressevent maximize, class:.*

      # Fix some dragging issues with XWayland
      windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

      exec-once = dunst
      exec-once = waybar
      exec-once = nm-applet --indicator
      exec-once = systemctl --user start hyprpolkitagent
    '';
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.numix-solarized-gtk-theme;
      name = "Numix";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
