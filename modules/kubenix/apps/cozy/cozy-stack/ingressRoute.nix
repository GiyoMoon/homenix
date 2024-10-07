{
  kubernetes.resources.ingressRoutes = {
    cozy-stack-root = {
      metadata = {
        name = "cozy-stack-root";
        namespace = "cozy";
        annotations = {
          "kubernetes.io/ingress.class" = "traefik-external";
        };
      };
      spec = {
        entryPoints = [ "websecure" ];
        routes = [
          {
            match = "Host(`cozy.jasi.app`)";
            kind = "Rule";
            services = [
              {
                name = "cozy-stack";
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
    cozy-stack-sub = {
      metadata = {
        name = "cozy-stack-sub";
        namespace = "cozy";
        annotations = {
          "kubernetes.io/ingress.class" = "traefik-external";
        };
      };
      spec = {
        entryPoints = [ "websecure" ];
        routes = [
          {
            match = "HostRegexp(`^.+\.cozy\.jasi\.app$`)";
            kind = "Rule";
            services = [
              {
                name = "cozy-stack";
                port = 80;
              }
            ];
          }
        ];
        tls = {
          secretName = "cozy-jasi-app";
        };
      };
    };
  };
}
