## Prerequisites
- Install nix
```
sh <(curl -L https://nixos.org/nix/install) --daemon
```
- Update public ssh keys in modules/common.nix
- Update age keys in .sops.yaml
- Run stuff
```bash
nix run github:serokell/deploy-rs .
```
