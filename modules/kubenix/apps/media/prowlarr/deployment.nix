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
              image = "ghcr.io/onedr0p/prowlarr:1.24.3.4754@sha256:0bafa88831a4164a253f74c8ff5cf82a1dbe5704068b1081b349e8f1026379c8";
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
