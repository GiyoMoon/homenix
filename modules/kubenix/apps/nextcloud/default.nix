{
  imports = [
    ./mariadb
    ./deployment.nix
    ./ingressRoute.nix
    ./pvc.nix
    ./service.nix
  ];

  kubernetes.resources.namespaces.nextcloud = { };
}
