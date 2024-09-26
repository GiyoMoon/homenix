{
  kubernetes.resources.deployments.jellyseerr = {
    metadata = {
      name = "jellyseerr";
      namespace = "media";
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
          app = "jellyseerr";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "jellyseerr";
          };
        };
        spec = {
          containers = [
            {
              name = "jellyseerr";
              image = "fallenbagel/jellyseerr:1.9.2@sha256:8f708df0ce3f202056bde5d7bff625eb59efe38f4ee47bdddc7560b6e4a5a214";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
              ];
              ports = [
                {
                  protocol = "TCP";
                  containerPort = 5055;
                }
              ];
              volumeMounts = [
                {
                  name = "jellyseerr-config";
                  mountPath = "/app/config";
                }
              ];
            }
          ];
          volumes = [
            {
              name = "jellyseerr-config";
              persistentVolumeClaim = {
                claimName = "jellyseerr-config";
              };
            }
          ];
        };
      };
    };
  };
}
