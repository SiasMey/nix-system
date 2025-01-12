{pkgs, ...}: {
  # Enable the X11 windowing system.
  services.xserver = {
    videoDrivers = ["nvidia"];
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.pam.services.hyprlock = {};

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "meysi";

  # Install firefox.
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    kitty

    hyprpolkitagent
    dunst
    hyprpaper
    hyprshot
    hyprpicker

    networkmanagerapplet
    libnotify
    rofi-wayland
    wl-clipboard
    wlogout

    gparted
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  security.rtkit.enable = true;
}
