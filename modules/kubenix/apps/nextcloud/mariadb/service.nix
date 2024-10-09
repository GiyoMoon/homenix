{
  kubernetes.resources.services.nextcloud-mariadb = {
    metadata = {
      name = "nextcloud-mariadb";
      namespace = "nextcloud";
      annotations = {
        "metallb.universe.tf/loadBalancerIPs" = "10.0.20.40";
        "metallb.universe.tf/allow-shared-ip" = "dns";
      };
    };
    spec = {
      type = "LoadBalancer";
      selector = {
        app = "nextcloud-mariadb";
      };
      ipFamilyPolicy = "PreferDualStack";
      ipFamilies = [ "IPv4" ];
      ports = [
        {
          protocol = "TCP";
          port = 33061;
          targetPort = 3306;
        }
      ];
    };
  };
}
