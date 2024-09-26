{
  kubernetes.resources.deployments.sonarr = {
    metadata = {
      name = "sonarr";
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
          app = "sonarr";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "sonarr";
          };
        };
        spec = {
          securityContext = {
            runAsNonRoot = true;
            runAsUser = 65534;
            runAsGroup = 65534;
            fsGroup = 65534;
            fsGroupChangePolicy = "OnRootMismatch";
          };
          containers = [
            {
              name = "sonarr";
              image = "ghcr.io/onedr0p/sonarr:4.0.9.2244@sha256:411bce3d24bcc3c64bd44b3babd85db34b111973d5e77094bd252b41043236f7";
              imagePullPolicy = "Always";
              resources = { };
              volumeMounts = [
                {
                  name = "sonarr-config";
                  mountPath = "/config";
                }
                {
                  name = "sonarr-downloads";
                  mountPath = "/downloads";
                }
              ];
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
              ];
            }
          ];
          volumes = [
            {
              name = "sonarr-config";
              persistentVolumeClaim = {
                claimName = "sonarr-config";
              };
            }
            {
              name = "sonarr-downloads";
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
