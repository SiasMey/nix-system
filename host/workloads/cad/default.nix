{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.workloads.cad;
in {
  options.workloads.cad = {
    enabled = lib.mkEnableOption "Enable Module";
  };
  config = lib.mkIf cfg.enabled {
    environment.systemPackages = with pkgs; [
      orca-slicer
      freecad-wayland
      openscad
      openscad-lsp
    ];
  };
}
