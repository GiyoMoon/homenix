<h1 align="center">Homenix</h1>
<div align="center">
 <strong>
  NixOS configuration for my homelab.
 </strong>
</div>

## First time setup
After flashing the base [NixOS image](https://github.com/GiyoMoon/nixos-turing-rk1) to the nodes, some setup is required for this config to work:
1. Change the `sshUser` to `nixos` in `flake.nix`. This is only required for the initial deploy, after that we'll use the root user with an ssh key.
2. Configure `sops-nix` with the node's public age keys.
```bash
# Get public age key on the node
sudo nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
# Update keys in `.sops.yaml`
# Re-encrypt files
nix-shell -p sops --run "sops updatekeys secrets/secrets.json"
```
3. Make sure to include your public ssh keys in `./modules/common.nix`.
4. For k3s to work properly, you first need to deploy `node1`, retrieve the server token with `cat /var/lib/rancher/k3s/server/token` and edit it in the secret file to make sure k3s agents can connect to the server.

## Deploy
Deploy the config:
```bash
nix run github:serokell/deploy-rs .
```
If you only want to deploy a certain node:
```bash
nix run github:serokell/deploy-rs .#node1
```
