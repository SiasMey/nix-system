{...}: {
  imports = [
    ../../scripts
    ../../workloads/linux
    ../../workloads/home.nix
    ../../workloads/editor.nix
  ];


  home.sessionVariables = {
    TERM="xterm";
  };
}
