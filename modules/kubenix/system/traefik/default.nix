{
  imports = [
    ./chart.nix
    ./dashboard
  ];
  kubernetes = {
    resources.namespaces.traefik = { };
    customTypes = [
      {
        attrName = "ingressRoutes";
        group = "traefik.io";
        kind = "IngressRoute";
        version = "v1alpha1";
      }
      {
        attrName = "middlewares";
        group = "traefik.io";
        kind = "Middleware";
        version = "v1alpha1";
      }
    ];
  };
}
