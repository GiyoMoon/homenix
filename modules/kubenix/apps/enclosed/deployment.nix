{
  kubernetes.resources.deployments.enclosed = {
    metadata = {
      name = "enclosed";
      namespace = "enclosed";
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
          app = "enclosed";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "enclosed";
          };
        };
        spec = {
          containers = [
            {
              name = "enclosed";
              image = "corentinth/enclosed:1.8.0@sha256:d57b54553c10195c6deee92ea07bee5b7dc20e2d45da7c3bc009c3dd3901c570";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "SERVER_CORS_ORIGINS";
                  value = "https://enclosed.jasi.app";
                }
                {
                  name = "AUTHENTICATION_JWT_SECRET";
                  valueFrom = {
                    secretKeyRef = {
                      name = "enclosed";
                      key = "jwt_secret";
                    };
                  };
                }
              ];
              volumeMounts = [
                {
                  name = "enclosed-data";
                  mountPath = "/app/.data";
                }
              ];
            }
          ];
          volumes = [
            {
              name = "enclosed-data";
              persistentVolumeClaim = {
                claimName = "enclosed-data";
              };
            }
          ];
        };
      };
    };
  };
}
