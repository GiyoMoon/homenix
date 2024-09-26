{
  kubernetes.resources.ingressRoutes.sonarr = {
    metadata = {
      name = "sonarr";
      namespace = "media";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`sonarr.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "sonarr";
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
