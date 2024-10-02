{ sops, ... }:
{
  kubernetes.resources.secrets = {
    cloudflare-ddns-config = {
      metadata = {
        namespace = "ddns";
      };
      stringData = {
        "config.json" = "ref+file://" + sops.secrets.cloudflare_ddns_config.path;
      };
    };
  };
}
