{ pkgs, inputs, ... }:
{
  kubernetes.helm.releases.reflector = {
    chart = pkgs.stdenvNoCC.mkDerivation {
      name = "reflector";
      src = inputs.reflector-chart;
      buildCommand = ''
        cp -r $src/ $out
      '';
    };
    namespace = "kube-system";
  };
}
