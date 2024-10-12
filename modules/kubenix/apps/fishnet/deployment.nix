{
  kubernetes.resources.deployments.fishnet = {
    metadata = {
      name = "fishnet";
      namespace = "fishnet";
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
          app = "fishnet";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "fishnet";
          };
        };
        spec = {
          containers = [
            {
              name = "fishnet";
              image = "niklasf/fishnet:2.9.4@sha256:36b62a778e317f12d82e0817ddb5c8031714a5eab0a1fb6e117c29d058589cd8";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
                {
                  name = "CORES";
                  value = "2";
                }
                {
                  name = "KEY";
                  valueFrom = {
                    secretKeyRef = {
                      name = "fishnet";
                      key = "fishnet_private_key";
                    };
                  };
                }
              ];
            }
          ];
        };
      };
    };
  };
}
