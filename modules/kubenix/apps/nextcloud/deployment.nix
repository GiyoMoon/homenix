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
              image = "linuxserver/nextcloud:30.0.2@sha256:085cba3d764613d1b7311cb55384aad594f34fc4b001a62e55b45e8944281ff0";
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
