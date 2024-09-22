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

  environment.etc."kubenix-unresolved.yaml".source =
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

  systemd.services.kubenixEval = {
    description = "kubenix secret eval";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = # bash
      ''
        cat /etc/kubenix-unresolved.yaml | ${pkgs.vals}/bin/vals eval > /etc/kubenix.yaml
      '';
    wantedBy = [ "multi-user.target" ];
  };

  system.activationScripts.kubenix.text = ''
    cat /etc/kubenix-unresolved.yaml | ${pkgs.vals}/bin/vals eval > /etc/kubenix.yaml
    ln -sf /etc/kubenix.yaml /var/lib/rancher/k3s/server/manifests/kubenix.yaml
  '';
}
