# === Warning ===
# This file is imported outside of the kubenix module
# ===============

{ inputs, ... }:
{
  environment.etc."cert-manager-crds.yaml".text = builtins.readFile inputs.cert-manager-crds;
  system.activationScripts.cert-manager-crds.text = ''
    ln -sf /etc/cert-manager-crds.yaml /var/lib/rancher/k3s/server/manifests/cert-manager-crds.yaml
  '';
}
