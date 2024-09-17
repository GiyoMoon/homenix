{ pkgs, inputs, ... }:
{
  kubernetes.helm.releases.longhorn = {
    chart = pkgs.stdenvNoCC.mkDerivation {
      name = "longhorn";
      src = inputs.longhorn-chart;
      buildCommand = ''
        cp -r $src/chart/ $out
      '';
    };
    namespace = "longhorn-system";
    includeCRDs = true;
    values = {
      defaultSettings = {
        defaultDataPath = "/storage";
        # backupTarget = "cifs://";
        # backupTargetCredentialSecret = "cifs-secret";
        service = {
          ui = {
            loadBalancerIP = "192.168.40.80";
            type = "LoadBalancer";
          };
        };
      };
    };
  };
}
