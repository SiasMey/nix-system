{pkgs, ...}: {
  # Enable the X11 windowing system.
  services.xserver = {
    # videoDrivers = ["nvidia"];
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
  services.displayManager.autoLogin.user = "siasm";

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
    rofi
    wl-clipboard
    wlogout

    gparted
    libbluray
    libdvdcss
    # makemkv
    # handbrake
    vlc
  ];

  security.rtkit.enable = true;

  services.dbus.enable = true;
  services.dbus.packages = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland];

  nixpkgs.overlays = [
    (self: super: {
      libbluray-full = super.libbluray.override {
        withAACS = true;
        withBDplus = true;
      };
    })
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.hyprland
    ];
    config = {
      hyprland.default = ["hyprland" "gtk"];
    };
  };
}
