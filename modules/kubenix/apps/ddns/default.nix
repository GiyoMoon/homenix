{
  imports = [
    ./deployment.nix
    ./secret.nix
  ];

  kubernetes.resources.namespaces.ddns = { };
}
