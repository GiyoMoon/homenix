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
                image = "itzg/minecraft-server:2024.10.2-java21@sha256:8bd119f65ef6e65bdb12f756bfb44a305b36b1adf868ade8027014fabc29c755";
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
                    value = "VANILLA";
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
                    name = "VIEW_DISTANCE";
                    value = "15";
                  }
                  # {
                  #   name = "CF_SLUG";
                  #   value = "ftb-stoneblock-3";
                  # }
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
                    name = "minecraft-data-vanilla";
                    mountPath = "/data";
                  }
                ];
              }
            ];
            volumes = [
              {
                name = "minecraft-data-vanilla";
                persistentVolumeClaim = {
                  claimName = "minecraft-data-vanilla";
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
                    name = "minecraft-data-vanilla";
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
                name = "minecraft-data-vanilla";
                persistentVolumeClaim = {
                  claimName = "minecraft-data-vanilla";
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
