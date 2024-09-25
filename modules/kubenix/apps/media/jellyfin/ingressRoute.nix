{
  kubernetes.resources.ingressRoutes.jellyfin = {
    metadata = {
      name = "jellyfin";
      namespace = "media";
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
          match = "Host(`jellyfin.jasi.app`)";
          services = [
            {
              name = "jellyfin-tcp";
              port = 80;
            }
          ];
        }
      ];
      tls = {
        secretName = "jasi-app";
      };
    };
  };
}
