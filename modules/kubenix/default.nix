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
            ./apps
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

  system.activationScripts.kubenix.text = # bash
    ''
      cat /etc/kubenix-unresolved.yaml | ${pkgs.vals}/bin/vals eval > /etc/kubenix.yaml
      ln -sf /etc/kubenix.yaml /var/lib/rancher/k3s/server/manifests/kubenix.yaml
    '';

  # 107374182400 = 100GiB (100 * 1024 * 1024 * 1024)
  system.activationScripts.kubeNodeConfig.text = # bash
    ''
      ${pkgs.k3s}/bin/kubectl label --overwrite node node1 node.longhorn.io/create-default-disk=config
      ${pkgs.k3s}/bin/kubectl annotate --overwrite node node1 node.longhorn.io/default-disks-config='
        [
          {"name":"ssd","path":"/storage","allowScheduling":true,"tags":["ssd"],"storageReserved":107374182400}
        ]
      '

      ${pkgs.k3s}/bin/kubectl label --overwrite node node3 node.longhorn.io/create-default-disk=config
      ${pkgs.k3s}/bin/kubectl annotate --overwrite node node3 node.longhorn.io/default-disks-config='
        [
          {"name":"ssd","path":"/storage","allowScheduling":true,"tags":["ssd"],"storageReserved":107374182400},
          {"name":"hdd","path":"/mnt/hdd/kubernetes","allowScheduling":true,"tags":["hdd"]}
        ]
      '
    '';
}
