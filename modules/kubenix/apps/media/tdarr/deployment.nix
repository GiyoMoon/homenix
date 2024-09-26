{
  kubernetes.resources.deployments.tdarr = {
    metadata = {
      name = "tdarr";
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
          app = "tdarr";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "tdarr";
          };
        };
        spec = {
          containers = [
            {
              name = "tdarr";
              image = "ghcr.io/haveagitgat/tdarr:2.26.01@sha256:a4a42a12022794fb7cd21fa173695aadcd17510274449c159d5fef44da3b6a1d";
              imagePullPolicy = "Always";
              resources = { };
              volumeMounts = [
                {
                  name = "tdarr-server";
                  mountPath = "/app/server";
                }
                {
                  name = "tdarr-config";
                  mountPath = "/app/configs";
                }
                {
                  name = "tdarr-media";
                  mountPath = "/media";
                }
              ];
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
                {
                  name = "serverPort";
                  value = "8266";
                }
                {
                  name = "webUIPort";
                  value = "8265";
                }
                {
                  name = "internalNode";
                  value = "true";
                }
                {
                  name = "inContainer";
                  value = "true";
                }
              ];
            }
          ];
          volumes = [
            {
              name = "tdarr-server";
              persistentVolumeClaim = {
                claimName = "tdarr-server";
              };
            }
            {
              name = "tdarr-config";
              persistentVolumeClaim = {
                claimName = "tdarr-config";
              };
            }
            {
              name = "tdarr-media";
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
