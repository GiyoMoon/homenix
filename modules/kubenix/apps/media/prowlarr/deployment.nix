{
  kubernetes.resources.deployments.prowlarr = {
    metadata = {
      name = "prowlarr";
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
          app = "prowlarr";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "prowlarr";
          };
        };
        spec = {
          securityContext = {
            runAsNonRoot = true;
            runAsUser = 1000;
            runAsGroup = 1000;
            fsGroup = 1000;
            fsGroupChangePolicy = "OnRootMismatch";
          };
          containers = [
            {
              name = "prowlarr";
              image = "ghcr.io/onedr0p/prowlarr:1.23.1.4708@sha256:63bf8d5bcf275043cf9bc94f50ac85b5e35775d3d217c0725300b4d54968db3e";
              imagePullPolicy = "Always";
              resources = { };
              volumeMounts = [
                {
                  name = "prowlarr-config";
                  mountPath = "/config";
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
              name = "prowlarr-config";
              persistentVolumeClaim = {
                claimName = "prowlarr-config";
              };
            }
          ];
        };
      };
    };
  };
}
