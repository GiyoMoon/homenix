{
  imports = [
    ./deployment.nix
    ./ingressRoute.nix
    ./pvc.nix
    ./secret.nix
    ./service.nix
  ];

  kubernetes.resources.namespaces.enclosed = { };
}
