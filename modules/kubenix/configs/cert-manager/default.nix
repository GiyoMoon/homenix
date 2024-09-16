{
  imports = [
    ./certificate.nix
    ./clusterIssuer.nix
    ./helm.nix
    ./secret.nix
  ];
  kubernetes.customTypes = [
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
}
