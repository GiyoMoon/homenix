{ sops, ... }:
{
  kubernetes.resources.deployments = {
    minecraft = {
      metadata = {
        name = "minecraft";
        namespace = "minecraft";
      };
      spec = {
        replicas = 1;
        strategy = {
          rollingUpdate = {
            maxSurge = 1;
            maxUnavailable = 1;
          };
          type = "RollingUpdate";
        };
        selector = {
          matchLabels = {
            app = "minecraft";
          };
        };
        template = {
          metadata = {
            labels = {
              app = "minecraft";
            };
          };
          spec = {
            containers = [
              {
                name = "minecraft";
                image = "itzg/minecraft-server:2024.10.0-java21@sha256:8e4850952064ac4e55ac7d302bf1beff6e25bb52f96d0bc524b9349e34b0ef4a";
                imagePullPolicy = "Always";
                resources = { };
                env = [
                  # === General ===
                  {
                    name = "TZ";
                    value = "Europe/Zurich";
                  }
                  {
                    name = "MEMORY";
                    value = "16G";
                  }
                  {
                    name = "ENABLE_ROLLING_LOGS";
                    value = "true";
                  }
                  # === Minecraft Server ===
                  {
                    name = "EULA";
                    value = "TRUE";
                  }
                  {
                    name = "TYPE";
                    value = "FABRIC";
                  }
                  {
                    name = "MOTD";
                    value = "Helo";
                  }
                  {
                    name = "DIFFICULTY";
                    value = "hard";
                  }
                  # === Whitelist ===
                  {
                    name = "ENABLE_WHITELIST";
                    value = "true";
                  }
                  {
                    name = "WHITELIST";
                    value = "ref+file://" + sops.secrets.minecraft_whitelist_uuids.path;
                  }
                  {
                    name = "RCON_PASSWORD";
                    value = "ref+file://" + sops.secrets.minecraft_rcon_password.path;
                  }
                ];
                volumeMounts = [
                  {
                    name = "minecraft-data";
                    mountPath = "/data";
                  }
                ];
              }
            ];
            volumes = [
              {
                name = "minecraft-data";
                persistentVolumeClaim = {
                  claimName = "minecraft-data";
                };
              }
            ];
          };
        };
      };
    };
    minecraft-backup = {
      metadata = {
        name = "minecraft-backup";
        namespace = "minecraft";
      };
      spec = {
        replicas = 1;
        strategy = {
          rollingUpdate = {
            maxSurge = 1;
            maxUnavailable = 1;
          };
          type = "RollingUpdate";
        };
        selector = {
          matchLabels = {
            app = "minecraft-backup";
          };
        };
        template = {
          metadata = {
            labels = {
              app = "minecraft-backup";
            };
          };
          spec = {
            containers = [
              {
                name = "minecraft-backup";
                image = "itzg/mc-backup:latest@sha256:c62972a87294f94a98e5d941441da8020cf86af887c5dabe9ab0ee43109a495f";
                imagePullPolicy = "Always";
                resources = { };
                env = [
                  {
                    name = "TZ";
                    value = "Europe/Zurich";
                  }
                  {
                    name = "RCON_HOST";
                    value = "10.0.20.30";
                  }
                  {
                    name = "RCON_PASSWORD";
                    value = "ref+file://" + sops.secrets.minecraft_rcon_password.path;
                  }
                ];
                volumeMounts = [
                  {
                    name = "minecraft-data";
                    mountPath = "/data";
                  }
                  {
                    name = "minecraft-backup";
                    mountPath = "/backups";
                  }
                ];
              }
            ];
            volumes = [
              {
                name = "minecraft-data";
                persistentVolumeClaim = {
                  claimName = "minecraft-data";
                };
              }
              {
                name = "minecraft-backup";
                persistentVolumeClaim = {
                  claimName = "minecraft-backup";
                };
              }
            ];
          };
        };
      };
    };
  };
}
