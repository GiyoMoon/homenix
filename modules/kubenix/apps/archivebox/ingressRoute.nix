{
  kubernetes.resources.ingressRoutes.archivebox = {
    metadata = {
      name = "archivebox";
      namespace = "archivebox";
      annotations = {
        "kubernetes.io/ingress.class" = "traefik-external";
      };
    };
    spec = {
      entryPoints = [ "websecure" ];
      routes = [
        {
          match = "Host(`archive.jasi.app`)";
          kind = "Rule";
          services = [
            {
              name = "archivebox";
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
