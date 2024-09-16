{
  kubernetes.resources.middlewares.traefik-dashboard = {
    metadata = {
      name = "traefik-dashboard-basicauth";
      namespace = "traefik";
    };
    spec = {
      basicAuth = {
        secret = "traefik-dashboard-auth";
      };
    };
  };
}
