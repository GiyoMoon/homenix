{ sops, ... }:
{
  kubernetes.resources.secrets = {
    traefik-dashboard-auth = {
      metadata = {
        namespace = "traefik";
      };
      stringData = {
        users = "ref+file://" + sops.secrets.traefik_dashboard_auth.path;
      };
    };
  };
}
