{
  kubernetes.resources.deployments.nzbget = {
    metadata = {
      name = "nzbget";
      namespace = "media";
    };
    spec = {
      replicas = 1;
      strategy = {
        type = "RollingUpdate";
        rollingUpdate = {
          maxSurge = 1;
          maxUnavailable = 1;
        };
      };
      selector = {
        matchLabels = {
          app = "nzbget";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "nzbget";
          };
        };
        spec = {
          # securityContext = {
          #   runAsNonRoot = true;
          #   runAsUser = 65534;
          #   runAsGroup = 65534;
          #   fsGroup = 65534;
          #   fsGroupChangePolicy = "OnRootMismatch";
          # };
          containers = [
            {
              name = "nzbget";
              image = "linuxserver/nzbget:24.3.20240920@sha256:fd7ade0a933dbcfe156863289be8c4feb10b539a8540961c0985baaa92290c72";
              imagePullPolicy = "Always";
              resources = { };
              volumeMounts = [
                {
                  name = "nzbget-config";
                  mountPath = "/config";
                }
                {
                  name = "nzbget-downloads";
                  mountPath = "/downloads";
                  subPath = "downloads/usenet";
                }
              ];
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
                {
                  name = "PUID";
                  value = "65534";
                }
                {
                  name = "PGID";
                  value = "65534";
                }
                {
                  name = "UMASK";
                  value = "000";
                }
                {
                  name = "NZBGET_USER";
                  valueFrom = {
                    secretKeyRef = {
                      name = "nzbget-auth";
                      key = "user";
                    };
                  };
                }
                {
                  name = "NZBGET_PASS";
                  valueFrom = {
                    secretKeyRef = {
                      name = "nzbget-auth";
                      key = "password";
                    };
                  };
                }
              ];
            }
          ];
          volumes = [
            {
              name = "nzbget-config";
              persistentVolumeClaim = {
                claimName = "nzbget-config";
              };
            }
            {
              name = "nzbget-downloads";
              persistentVolumeClaim = {
                claimName = "jellyfin-data";
              };
            }
          ];
        };
      };
    };
  };
}
