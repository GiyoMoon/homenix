{
  # sudo -u abc php -f /app/www/public/occ files:scan {username}
  imports = [
    ./mariadb
    ./deployment.nix
    ./ingressRoute.nix
    ./pvc.nix
    ./service.nix
  ];

  kubernetes.resources.namespaces.nextcloud = { };
}
