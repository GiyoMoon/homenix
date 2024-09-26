{
  kubernetes.resources.services = {
    pihole-tcp = {
      metadata = {
        name = "pihole-tcp";
        namespace = "pihole";
        annotations = {
          "metallb.universe.tf/loadBalancerIPs" = "10.0.20.20";
          "metallb.universe.tf/allow-shared-ip" = "dns";
        };
      };
      spec = {
        type = "LoadBalancer";
        selector = {
          app = "pihole";
        };
        ipFamilyPolicy = "PreferDualStack";
        ipFamilies = [ "IPv4" ];
        ports = [
          {
            protocol = "TCP";
            name = "pihole-admin";
            port = 80;
            targetPort = 80;
          }
          {
            protocol = "TCP";
            name = "dns-tcp";
            port = 53;
            targetPort = 53;
          }
        ];
      };
    };
    pihole-udp = {
      metadata = {
        name = "pihole-udp";
        namespace = "pihole";
        annotations = {
          "metallb.universe.tf/loadBalancerIPs" = "10.0.20.20";
          "metallb.universe.tf/allow-shared-ip" = "dns";
        };
      };
      spec = {
        type = "LoadBalancer";
        selector = {
          app = "pihole";
        };
        ipFamilyPolicy = "PreferDualStack";
        ipFamilies = [ "IPv4" ];
        ports = [
          {
            protocol = "UDP";
            name = "dns-udp";
            port = 53;
            targetPort = 53;
          }
        ];
      };
    };
  };
}
