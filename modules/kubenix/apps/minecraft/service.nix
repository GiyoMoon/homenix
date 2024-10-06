{
  kubernetes.resources.services.minecraft = {
    metadata = {
      name = "minecraft";
      namespace = "minecraft";
      annotations = {
        "metallb.universe.tf/loadBalancerIPs" = "10.0.20.30";
        "metallb.universe.tf/allow-shared-ip" = "dns";
      };
    };
    spec = {
      type = "LoadBalancer";
      selector = {
        app = "minecraft";
      };
      ipFamilyPolicy = "PreferDualStack";
      ipFamilies = [ "IPv4" ];
      ports = [
        {
          name = "minecraft";
          protocol = "TCP";
          port = 25565;
          targetPort = 25565;
        }
        {
          name = "rcon";
          protocol = "TCP";
          port = 25575;
          targetPort = 25575;
        }
      ];
    };
  };
}
