{
  kubernetes.resources.ingressRoutes.prowlarr = {
    metadata = {
      name = "prowlarr";
      namespace = "media";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`prowlarr.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "prowlarr";
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
