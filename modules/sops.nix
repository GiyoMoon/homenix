{ ... }:

{
  sops.defaultSopsFile = ../secrets/secrets.json;
  sops.defaultSopsFormat = "json";

  sops.secrets.k3s_token = { };
  sops.secrets.cloudflare_email = { };
  sops.secrets.cloudflare_api_key = { };
  sops.secrets.traefik_dashboard_auth = { };
  sops.secrets.letsencrypt_email = { };
}
