{
  kubernetes.resources.ingressRoutes.nzbget = {
    metadata = {
      name = "nzbget";
      namespace = "media";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`nzbget.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "nzbget";
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
