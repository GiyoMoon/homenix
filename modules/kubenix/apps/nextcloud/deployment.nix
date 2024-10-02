{
  kubernetes.resources.deployments.nextcloud = {
    metadata = {
      name = "nextcloud";
      namespace = "nextcloud";
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
          app = "nextcloud";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "nextcloud";
          };
        };
        spec = {
          containers = [
            {
              name = "nextcloud";
              image = "linuxserver/nextcloud:30.0.0@sha256:6fb470054fe7faaa3297604ac8ae64116905b7b6a3669b3bdbdcc8a15407848d";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
              ];
              volumeMounts = [
                {
                  name = "nextcloud-config";
                  mountPath = "/config";
                }
                {
                  name = "nextcloud-data";
                  mountPath = "/data";
                }
              ];
            }
          ];
          volumes = [
            {
              name = "nextcloud-config";
              persistentVolumeClaim = {
                claimName = "nextcloud-config";
              };
            }
            {
              name = "nextcloud-data";
              persistentVolumeClaim = {
                claimName = "nextcloud-data";
              };
            }
          ];
        };
      };
    };
  };
}
