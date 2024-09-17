{
  imports = [
    ./certificate.nix
    ./clusterIssuer.nix
    ./chart.nix
    ./secret.nix
  ];

  kubernetes = {
    resources.namespaces.cert-manager = { };
    customTypes = [
      {
        attrName = "certificates";
        group = "cert-manager.io";
        kind = "Certificate";
        version = "v1";
      }
      {
        attrName = "clusterIssuers";
        group = "cert-manager.io";
        kind = "ClusterIssuer";
        version = "v1";
      }
    ];
  };
}
