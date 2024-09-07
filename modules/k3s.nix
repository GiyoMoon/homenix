{ config, meta, ... }:
{
  networking.firewall = {
    allowedTCPPorts = [ 6443 ];
    allowedUDPPorts = [ 8472 ];
  };

  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = config.sops.secrets.k3s_token.path;
    clusterInit = (meta.hostname == "node1");
    serverAddr = if (meta.hostname != "node1") then "https://node1.lan:6443" else "";
  };
}
