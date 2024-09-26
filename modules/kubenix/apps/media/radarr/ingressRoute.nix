{
  kubernetes.resources.ingressRoutes.radarr = {
    metadata = {
      name = "radarr";
      namespace = "media";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`radarr.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "radarr";
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
