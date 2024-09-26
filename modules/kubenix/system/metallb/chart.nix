{ pkgs, inputs, ... }:
{
  kubernetes.helm.releases.metallb = {
    chart = pkgs.stdenvNoCC.mkDerivation {
      name = "metallb";
      src = inputs.metallb-chart;
      buildCommand = ''
        cp -r $src/ $out
      '';
    };
    namespace = "metallb-system";
    includeCRDs = true;
    values = { };
  };
}
