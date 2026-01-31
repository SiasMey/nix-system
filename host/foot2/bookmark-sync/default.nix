{...}: {
  services.karakeep = {
    enable = true;
    extraEnvironment = {
      NEXTAUTH_URL = "https://bookmarks.dwarf-foot.dev";
      NEXTAUTH_URL_INTERNAL = "http://localhost:3000";
      DISABLE_PASSWORD_AUTH = "true";
      DISABLE_SIGNUPS = "true";
      DISABLE_NEW_RELEASE_CHECK = "true";
      OAUTH_WELLKNOWN_URL = "https://auth.dwarf-foot.dev/.well-known/openid-configuration";
      OAUTH_CLIENT_SECRET = "h9uj9xD1clDktYht8rkDcVICa3rSy9h9";
      OAUTH_CLIENT_ID = "30889fe8-207e-403f-806f-148846854f74";
      OAUTH_PROVIDER_NAME = "Dwarf-foot Auth";
      OAUTH_ALLOW_DANGEROUS_EMAIL_ACCOUNT_LINKING = "true";
    };
  };
  services.meilisearch = {
    enable =  true;
  };
}
