{
  config,
  kubenix,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./system/cert-manager/crds.nix
  ];

  environment.etc."kubenix.yaml".source =
    (kubenix.evalModules.aarch64-linux {
      module =
        { kubenix, ... }:
        {
          imports = [
            kubenix.modules.k8s
            kubenix.modules.helm
            ./system
          ];
        };
      specialArgs = {
        inherit inputs;
        sops = config.sops;
      };
    }).config.kubernetes.resultYAML;

  # TODO: Make this survive reboots
  system.activationScripts.kubenix.text = ''
    cat /etc/kubenix.yaml | ${pkgs.vals}/bin/vals eval > /var/lib/rancher/k3s/server/manifests/kubenix.yaml
  '';
}
