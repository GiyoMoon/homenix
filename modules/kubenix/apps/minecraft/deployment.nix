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
                image = "itzg/minecraft-server:2024.10.0-java17@sha256:e4869a9eb294dae5e40b4bc8c3566787592472476edb4b13daba1a8180be5efa";
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
                    value = "AUTO_CURSEFORGE";
                  }
                  {
                    name = "MOTD";
                    value = "Sponsored by jasi";
                  }
                  {
                    name = "DIFFICULTY";
                    value = "normal";
                  }
                  {
                    name = "CF_SLUG";
                    value = "ftb-stoneblock-3";
                  }
                  {
                    name = "CF_API_KEY";
                    value = "ref+file://" + sops.secrets.minecraft_curseforge_api_key.path;
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
                  # {
                  #   name = "LEVEL_TYPE";
                  #   value = "default";
                  # }
                  # {
                  #   name = "CUSTOM_SERVER_PROPERTIES";
                  #   value = ''
                  #     generator-settings={"Topography-Preset":"Sky Factory 4"}
                  #   '';
                  # }
                ];
                volumeMounts = [
                  {
                    name = "minecraft-data-stoneblock-3";
                    mountPath = "/data";
                  }
                ];
              }
            ];
            volumes = [
              {
                name = "minecraft-data-stoneblock-3";
                persistentVolumeClaim = {
                  claimName = "minecraft-data-stoneblock-3";
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
                    name = "minecraft-data-stoneblock-3";
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
                name = "minecraft-data-stoneblock-3";
                persistentVolumeClaim = {
                  claimName = "minecraft-data-stoneblock-3";
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
