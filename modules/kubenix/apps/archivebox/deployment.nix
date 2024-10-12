{
  kubernetes.resources.deployments.archivebox = {
    metadata = {
      name = "archivebox";
      namespace = "archivebox";
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
          app = "archivebox";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "archivebox";
          };
        };
        spec = {
          containers = [
            {
              name = "archivebox";
              image = "archivebox/archivebox:0.7.2@sha256:8f51a6dab258198ff9616281bff13545c36cb4d65eb6221e322261cce1ee42ac";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "CSRF_TRUSTED_ORIGINS";
                  value = "https://archive.jasi.app";
                }
                {
                  name = "ALLOWED_HOSTS";
                  value = "*";
                }
                {
                  name = "PUBLIC_INDEX";
                  value = "False";
                }
                {
                  name = "PUBLIC_SNAPSHOTS";
                  value = "True";
                }
                {
                  name = "PUBLIC_ADD_VIEW";
                  value = "False";
                }
                {
                  name = "WGET_USER_AGENT";
                  value = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36";
                }
              ];
              volumeMounts = [
                {
                  name = "archivebox-data";
                  mountPath = "/data";
                }
              ];
            }
          ];
          volumes = [
            {
              name = "archivebox-data";
              persistentVolumeClaim = {
                claimName = "archivebox-data";
              };
            }
          ];
        };
      };
    };
  };
}
