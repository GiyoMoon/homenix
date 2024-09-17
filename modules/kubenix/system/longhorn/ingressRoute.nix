{
  kubernetes.resources.ingressRoutes.longhorn-ui = {
    metadata = {
      name = "longhorn-ui";
      namespace = "longhorn-system";
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
          match = "Host(`longhorn.local.jasi.app`)";
          services = [
            {
              name = "longhorn-frontend";
              port = 80;
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
