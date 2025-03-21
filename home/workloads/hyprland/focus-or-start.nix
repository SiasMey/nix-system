{pkgs}:
pkgs.writeShellApplication {
  name = "focus-or-start";

  runtimeInputs = [pkgs.jq];

  text = ''
    CURRENT_WS=$(hyprctl activeworkspace -j | jq -r .id)
    WORKSPACE=$(hyprctl clients -j | jq -r ".[] | select(.class == \"$2\") | .workspace.id" | uniq)

    if [ "$CURRENT_WS" == "$WORKSPACE" ]; then
      hyprctl dispatch cyclenext
    else
      if [ -n "$WORKSPACE" ]; then
        hyprctl dispatch workspace "$WORKSPACE"
      else
        hyprctl dispatch exec "$1"
      fi
    fi
  '';
}
