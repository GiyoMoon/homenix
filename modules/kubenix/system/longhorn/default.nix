{
  imports = [
    ./chart.nix
    ./ingressRoute.nix
    ./storageClass.nix
  ];

  kubernetes.resources.namespaces.longhorn-system = { };
}
