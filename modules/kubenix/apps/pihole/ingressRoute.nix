{
  kubernetes.resources.ingressRoutes.pihole = {
    metadata = {
      name = "pihole";
      namespace = "pihole";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`pihole.local.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "pihole-tcp";
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
