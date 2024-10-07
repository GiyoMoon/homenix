{
  kubernetes.resources.services.cozy-couchdb = {
    metadata = {
      name = "couchdb";
      namespace = "cozy";
      annotations = {
        "metallb.universe.tf/loadBalancerIPs" = "10.0.20.40";
        "metallb.universe.tf/allow-shared-ip" = "dns";
      };
    };
    spec = {
      type = "LoadBalancer";
      selector = {
        app = "couchdb";
      };
      ipFamilyPolicy = "PreferDualStack";
      ipFamilies = [ "IPv4" ];
      ports = [
        {
          protocol = "TCP";
          port = 5984;
          targetPort = 5984;
        }
      ];
    };
  };
}
