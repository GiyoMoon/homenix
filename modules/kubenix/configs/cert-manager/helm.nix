{ pkgs, inputs, ... }:
{
  kubernetes.helm.releases.cert-manager = {
    chart = pkgs.stdenvNoCC.mkDerivation {
      name = "cert-manager";
      src = inputs.cert-manager-chart;
      buildCommand = ''
        cp -r $src/ $out
      '';
    };
    namespace = "traefik";
    overrideNamespace = false;
    # cert-manager chart doesn't include CRDs
    includeCRDs = false;
    values = {
      replicaCount = 1;
      extraArgs = [
        "--dns01-recursive-nameservers=1.1.1.1:53,9.9.9.9:53"
        "--dns01-recursive-nameservers-only"
      ];
      podDnsPolicy = "None";
      podDnsConfig = {
        nameservers = [
          "1.1.1.1"
          "9.9.9.9"
        ];
      };
    };
  };
}
