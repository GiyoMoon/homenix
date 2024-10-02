{ ... }:

{
  sops.defaultSopsFile = ../secrets/secrets.json;
  sops.defaultSopsFormat = "json";

  sops.secrets.k3s_token = { };
  sops.secrets.cloudflare_email = { };
  sops.secrets.cloudflare_api_key = { };
  sops.secrets.traefik_dashboard_auth = { };
  sops.secrets.letsencrypt_email = { };
  sops.secrets.nzbget_auth_user = { };
  sops.secrets.nzbget_auth_password = { };
  sops.secrets.pihole_password = { };
  sops.secrets.longhorn_backup_target = { };
  sops.secrets.longhorn_backup_username = { };
  sops.secrets.longhorn_backup_password = { };
  sops.secrets.cloudflare_ddns_config = { };
}
