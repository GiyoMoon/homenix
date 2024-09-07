{
  description = "NixOS configuration for my homelab nodes";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };
    turing-rk1 = {
      url = "github:GiyoMoon/nixos-turing-rk1";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      deploy-rs,
      sops-nix,
      turing-rk1,
    }:
    let
      system = "aarch64-linux";
    in
    {
      nixosConfigurations = {
        node1 = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            meta = {
              hostname = "node1";
            };
          };

          modules = [
            turing-rk1.nixosModules.turing-rk1
            sops-nix.nixosModules.sops
            ./modules/default.nix
          ];
        };
        node3 = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            meta = {
              hostname = "node3";
            };
          };

          modules = [
            turing-rk1.nixosModules.turing-rk1
            sops-nix.nixosModules.sops
            ./modules/default.nix
          ];
        };
      };

      deploy.nodes = {
        node1 = {
          hostname = "node1.lan";
          sshUser = "root";
          # Enable on first run
          # sshUser = "nixos";
          user = "root";
          magicRollback = false;
          profiles.system.path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.node1;
        };
        node3 = {
          hostname = "node3.lan";
          sshUser = "root";
          # Enable on first run
          # sshUser = "nixos";
          user = "root";
          magicRollback = false;
          profiles.system.path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.node3;
        };
      };
    };
}
