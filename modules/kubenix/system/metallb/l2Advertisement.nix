{
  kubernetes.resources.l2Advertisements.default = {
    metadata = {
      name = "default";
      namespace = "metallb-system";
    };
    spec = {
      ipAddressPools = [ "default-pool" ];
    };
  };
}
