{
  lib,
  config,
  meta,
  ...
}:
let
  isMainNode = meta.hostname == "node1";
  serverNodes = [ "node1" ];
  role = if builtins.elem meta.hostname serverNodes then "server" else "agent";
in
{
  networking.firewall = {
    allowedTCPPorts = [
      6443 # K3s supervisor and Kubernetes API Server
      # 2379 # Required only for HA with embedded etcd
      # 2380 # Required only for HA with embedded etcd
    ];
    allowedUDPPorts = [
      8472 # Required only for Flannel VXLAN
    ];
  };

  services.k3s = {
    enable = true;
    inherit role;
    # Get token
    # cat /var/lib/rancher/k3s/server/token
    tokenFile = config.sops.secrets.k3s_token.path;
    clusterInit = isMainNode;
    serverAddr = if !isMainNode then "https://node1.lan:6443" else "";
    extraFlags =
      [
        # "--cluster-reset" # If everything breaks, this will save you :3
      ]
      ++ lib.optionals (role == "server") [
        ("--tls-san " + meta.hostname + ".lan")
      ];
  };
}
