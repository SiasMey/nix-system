{...}: {
  imports = [
    ../../scripts
    ../../workloads/home.nix
    ../../workloads/editor.nix
  ];


  home.sessionVariables = {
    TERM="xterm";
  };
}
