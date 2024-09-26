{
  kubernetes.resources.ingressRoutes.jellyseerr = {
    metadata = {
      name = "jellyseerr";
      namespace = "media";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`jellyseerr.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "jellyseerr";
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
