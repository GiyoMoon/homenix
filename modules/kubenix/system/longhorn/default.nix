{
  imports = [
    ./chart.nix
    ./ingressRoute.nix
  ];

  kubernetes.resources.namespaces.longhorn-system = { };
}
