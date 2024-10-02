{
  kubernetes.resources.certificates.jasi-app = {
    metadata = {
      name = "jasi-app";
      namespace = "cert-manager";
    };
    spec = {
      secretName = "jasi-app";
      issuerRef = {
        name = "letsencrypt";
        kind = "ClusterIssuer";
      };
      commonName = "*.jasi.app";
      dnsNames = [
        "jasi.app"
        "*.jasi.app"
      ];
      secretTemplate = {
        annotations = {
          "reflector.v1.k8s.emberstack.com/reflection-allowed" = "true";
          "reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces" = "media,nextcloud";
          "reflector.v1.k8s.emberstack.com/reflection-auto-enabled" = "true";
          "reflector.v1.k8s.emberstack.com/reflection-auto-namespaces" = "media,nextcloud";
        };
      };
    };
  };
  kubernetes.resources.certificates.local-jasi-app = {
    metadata = {
      name = "local-jasi-app";
      namespace = "cert-manager";
    };
    spec = {
      secretName = "local-jasi-app";
      issuerRef = {
        name = "letsencrypt";
        kind = "ClusterIssuer";
      };
      commonName = "*.local.jasi.app";
      dnsNames = [
        "local.jasi.app"
        "*.local.jasi.app"
      ];
      secretTemplate = {
        annotations = {
          "reflector.v1.k8s.emberstack.com/reflection-allowed" = "true";
          "reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces" = "traefik,pihole,longhorn-system";
          "reflector.v1.k8s.emberstack.com/reflection-auto-enabled" = "true";
          "reflector.v1.k8s.emberstack.com/reflection-auto-namespaces" = "traefik,pihole,longhorn-system";
        };
      };
    };
  };
}
