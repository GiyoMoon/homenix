{ config, meta, ... }:
{
  networking.firewall = {
    allowedTCPPorts = [
      6443 # K3s supervisor and Kubernetes API Server
      2379 # Required only for HA with embedded etcd
      2380 # Required only for HA with embedded etcd
    ];
    allowedUDPPorts = [
      8472 # Required only for Flannel VXLAN
    ];
  };

  services.k3s = {
    enable = true;
    role = "server";
    # Get token
    # cat /var/lib/rancher/k3s/server/token
    tokenFile = config.sops.secrets.k3s_token.path;
    clusterInit = (meta.hostname == "node1");
    serverAddr = if (meta.hostname != "node1") then "https://node1.lan:6443" else "";
    extraFlags = [
      ("--tls-san " + meta.hostname + ".lan")
    ];
  };
}
