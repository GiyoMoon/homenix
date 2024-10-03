{
  kubernetes.resources.ingressRoutes.nextcloud = {
    metadata = {
      name = "nextcloud";
      namespace = "nextcloud";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`cloud.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "nextcloud";
              port = 443;
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
