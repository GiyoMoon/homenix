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
        createDefaultDiskLabeledNodes = true;
        defaultDataPath = "/storage";
        # backupTarget = "cifs://";
        # backupTargetCredentialSecret = "cifs-secret";
      };
    };
  };
}
