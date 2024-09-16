{ sops, ... }:

{
  kubernetes.resources.secrets.cloudflare = {
    metadata = {
      namespace = "traefik";
    };
    stringData = {
      api_key = "ref+file://" + sops.secrets.cloudflare_api_key.path;
    };
  };
}
