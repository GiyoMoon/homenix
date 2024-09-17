{
  kubernetes.resources.ingressRoutes.traefik-dashboard = {
    metadata = {
      name = "traefik-dashboard";
      namespace = "traefik";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [
        "websecure"
      ];
      routes = [
        {
          kind = "Rule";
          match = "Host(`traefik.local.jasi.app`)";
          middlewares = [
            {
              name = "traefik-dashboard-basicauth";
              namespace = "traefik";
            }
          ];
          services = [
            {
              name = "api@internal";
              kind = "TraefikService";
            }
          ];
        }
      ];
      tls = {
        secretName = "local-jasi-app";
      };
    };
  };
}
