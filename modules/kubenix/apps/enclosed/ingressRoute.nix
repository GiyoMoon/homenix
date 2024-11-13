{
  kubernetes.resources.ingressRoutes.enclosed = {
    metadata = {
      name = "enclosed";
      namespace = "enclosed";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`enclosed.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "enclosed";
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
