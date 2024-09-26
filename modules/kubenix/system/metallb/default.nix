{
  imports = [
    ./chart.nix
    ./ipAddressPool.nix
    ./l2Advertisement.nix
  ];
  kubernetes = {
    resources.namespaces.metallb-system = { };
    customTypes = [
      {
        attrName = "ipAddressPools";
        group = "metallb.io";
        kind = "IPAddressPool";
        version = "v1beta1";
      }
      {
        attrName = "l2Advertisements";
        group = "metallb.io";
        kind = "L2Advertisement";
        version = "v1beta1";
      }
    ];
  };
}
