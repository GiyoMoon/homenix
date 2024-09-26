{
  kubernetes.resources.deployments.radarr = {
    metadata = {
      name = "radarr";
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
          app = "radarr";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "radarr";
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
              name = "radarr";
              image = "ghcr.io/onedr0p/radarr:5.11.0.9244@sha256:979669f2573983250746b5220299f05ac57421cf35cb6f71450dd01eb630d03d";
              imagePullPolicy = "Always";
              resources = { };
              volumeMounts = [
                {
                  name = "radarr-config";
                  mountPath = "/config";
                }
                {
                  name = "radarr-downloads";
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
              name = "radarr-config";
              persistentVolumeClaim = {
                claimName = "radarr-config";
              };
            }
            {
              name = "radarr-downloads";
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
