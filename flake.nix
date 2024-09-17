{
  description = "NixOS configuration for my homelab nodes";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    turing-rk1 = {
      url = "github:GiyoMoon/nixos-turing-rk1";
      # Don't follow nixpkgs, or we'd need to rebuild whole kernel on every nixpkgs update
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kubenix = {
      url = "github:hall/kubenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    traefik-chart = {
      url = "github:traefik/traefik-helm-chart";
      flake = false;
    };

    cert-manager-chart = {
      url = "https://charts.jetstack.io/charts/cert-manager-v1.15.3.tgz";
      flake = false;
    };
    cert-manager-crds = {
      url = "https://github.com/cert-manager/cert-manager/releases/download/v1.15.3/cert-manager.crds.yaml";
      flake = false;
    };

    reflector-chart = {
      url = "https://github.com/emberstack/helm-charts/raw/main/repository/reflector/reflector-7.1.288.tgz";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      deploy-rs,
      sops-nix,
      turing-rk1,
      kubenix,
      ...
    }@inputs:
    let
      system = "aarch64-linux";
    in
    {
      nixosConfigurations = {
        node1 = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit kubenix inputs;
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
            inherit inputs;
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
