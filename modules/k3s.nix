{
  lib,
  config,
  meta,
  pkgs,
  ...
}:
let
  isMainNode = meta.hostname == "node1";
  serverNodes = [ "node1" ];
  role = if builtins.elem meta.hostname serverNodes then "server" else "agent";
in
{
  imports = if isMainNode then [ ./kubenix ] else [ ];

  networking.firewall = {
    allowedTCPPorts = [
      6443 # K3s supervisor and Kubernetes API Server
      # 2379 # Required only for HA with embedded etcd
      # 2380 # Required only for HA with embedded etcd
      53
      80
      443
      7946
    ];
    allowedUDPPorts = [
      8472 # Required only for Flannel VXLAN
      53
      7946
    ];
  };

  environment.systemPackages = with pkgs; [
    openiscsi
    nfs-utils
    ipset
  ];

  services.openiscsi = {
    enable = true;
    name = "iqn.2020-08.org.linux-iscsi.initiatorhost:${meta.hostname}";
  };

  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  systemd.services.k3s.path = with pkgs; [
    openiscsi
    nfs-utils
    ipset
  ];

  services.k3s = {
    enable = true;
    inherit role;
    clusterInit = isMainNode;
    # Get token from main node
    # cat /var/lib/rancher/k3s/server/token
    tokenFile = if !isMainNode then config.sops.secrets.k3s_token.path else null;
    serverAddr = if !isMainNode then "https://node1.lan:6443" else "";
    extraFlags = lib.optionals (role == "server") [
      # "--cluster-reset" # If everything breaks, this will save you :3
      "--disable=traefik"
      "--disable=metrics-server"
      "--disable=local-storage"
      "--disable=servicelb"
      ("--tls-san " + meta.hostname + ".lan")
    ];
  };
}
