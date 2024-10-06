{
  imports = [
    ./deployment.nix
    ./pvc.nix
    ./service.nix
  ];

  kubernetes.resources.namespaces.minecraft = { };
}
