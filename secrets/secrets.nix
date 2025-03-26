let
  siasm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0idNvgGiucWgup/mP78zyC23uFjYq0evcWdjGQUaBH";
  users = [siasm];

  foot2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIdzFIWAy5o3XjT2THDr7n2m8r+0vHlJY9p1n/JsG42P";
  foot3 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFD6/BKZ9L3VXWyTCJHHsMmmvVWxD/x7sIuy81/Dl24V";
  systems = [foot2 foot3];
in {
  "secret.age".publicKeys = users ++ systems;
}
