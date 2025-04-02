{ pkgs }:
pkgs.writeShellApplication {
  name = "focus-or-start";

  runtimeInputs = [ pkgs.jq ];

  text = ''
    WINDOW_ID=$(aerospace list-windows --all --json | jq -r ".[] | select(.[\"app-name\"]==\"$2\") | .[\"window-id\"]")
    WORKSPACE_WINDOW_ID=$(aerospace list-windows --workspace focused --json | jq -r ".[] | select(.[\"app-name\"]==\"$2\") | .[\"window-id\"]")

    if [ -n "$WORKSPACE_WINDOW_ID" ]; then
      aerospace focus --boundaries-action wrap-around-the-workspace right
    else
      if [ -n "$WINDOW_ID" ]; then
        aerospace focus --window-id "$WINDOW_ID"
      else
        open -a "$1"
      fi
    fi
  '';
}
