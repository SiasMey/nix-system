{...}: {
  systemd.services.system-secrets = {
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    description = "Store bws api-key in /run/secrets/bws";
    serviceConfig = {
      ExecPreStart = ''/usr/bin/env mkdir -p /run/secrets'';
      ExecStart = ''/usr/bin/env cp $BWS_PATH /run/secrets/bws'';
      Environment = ''BWS_PATH=%d/bws'';
      SetCredentialEncrypted = ''        bws: \
                  Whxqht+dQJax1aZeCGLxmiAAAAABAAAADAAAABAAAABUnuiphvgpWpO8YYAAAAAA2nijC \
                  7POBN6yZPSl2z6fEZz8WF7Q+5ahtju0J2a0ijIU0VtaatQQ02rl/O5lB6lt+PPeKTWhMb \
                  V4fdiQqqFITYQID0v+Bf96V0lvOXEtzIOCzOd4dfWSPL9ZthoCXFY5jH9Ydcj67NYZiAt \
                  H34WITSO3pjx1fK6eyus37ShLlF4449lE1AGV'';
    };
  };
}
