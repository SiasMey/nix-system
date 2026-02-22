{...}: {
  services.homebox = {
    enable = true;
    settings = {
      HBOX_OIDC_ENABLED = "true";
      HBOX_OIDC_ISSUER_URL = "https://auth.dwarf-foot.dev";
      HBOX_OIDC_CLIENT_ID = "69ece392-7335-4f8c-8325-23c4bed22c8a";
      HBOX_OIDC_CLIENT_SECRET = "R2xrJGfR5cRDJ3m4vjpu29HjA4bEOUV9";
      HBOX_OPTIONS_TRUST_PROXY = "true";
      HBOX_OPTIONS_HOSTNAME = "boxes.dwarf-foot.dev";
      HBOX_OIDC_AUTO_REDIRECT = "true";
      HBOX_OPTIONS_ALLOW_LOCAL_LOGIN = "false";
      HBOX_OPTIONS_GITHUB_RELEASE_CHECK = "false";
      HBOX_OIDC_SCOPE = "openid profile email groups";
    };
  };
}
