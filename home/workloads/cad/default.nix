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
    home.packages = [
      pkgs.orca-slicer
      pkgs.freecad-wayland
      pkgs.openscad
      pkgs.openscad-lsp
    ];
  };
}
