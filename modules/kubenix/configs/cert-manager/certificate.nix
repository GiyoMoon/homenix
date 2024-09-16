{
  kubernetes.resources.certificates.jasi-app = {
    metadata = {
      name = "jasi-app";
      namespace = "traefik";
    };
    spec = {
      secretName = "jasi-app-tls";
      issuerRef = {
        name = "letsencrypt";
        kind = "ClusterIssuer";
      };
      commonName = "*.jasi.app";
      dnsNames = [
        "jasi.app"
        "*.jasi.app"
      ];
    };
  };
}
