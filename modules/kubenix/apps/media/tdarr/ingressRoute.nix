{
  kubernetes.resources.ingressRoutes.tdarr = {
    metadata = {
      name = "tdarr";
      namespace = "media";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`tdarr.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "tdarr";
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
