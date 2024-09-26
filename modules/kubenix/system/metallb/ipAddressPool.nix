{
  kubernetes.resources.ipAddressPools.default-pool = {
    metadata = {
      name = "default-pool";
      namespace = "metallb-system";
    };
    spec = {
      addresses = [ "10.0.20.0/24" ];
    };
  };
}
