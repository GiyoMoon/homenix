{
  config,
  kubenix,
  inputs,
  pkgs,
  ...
}:
{
  environment.etc."kubenix.yaml".source =
    (kubenix.evalModules.aarch64-linux {
      module =
        { kubenix, ... }:
        {
          imports = [
            kubenix.modules.k8s
            kubenix.modules.helm
            ./configs/traefik
            ./configs/traefik-dashboard
            ./configs/cert-manager
          ];
        };
      specialArgs = {
        inherit inputs;
        sops = config.sops;
      };
    }).config.kubernetes.resultYAML;

  environment.etc."cert-manager-crds.yaml".text = builtins.readFile inputs.cert-manager-crds;

  # TODO: Make this survive reboots
  system.activationScripts.kubenix.text = ''
    cat /etc/kubenix.yaml | ${pkgs.vals}/bin/vals eval > /var/lib/rancher/k3s/server/manifests/kubenix.yaml
    ln -sf /etc/cert-manager-crds.yaml /var/lib/rancher/k3s/server/manifests/cert-manager-crds.yaml
    ln -sf /etc/cert-manager-crds.yaml /var/lib/rancher/k3s/server/manifests/cert-manager-crds.yaml
  '';
}
