{
  kubernetes.resources.deployments.nzbget = {
    metadata = {
      name = "nzbget";
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
          app = "nzbget";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "nzbget";
          };
        };
        spec = {
          containers = [
            {
              name = "nzbget";
              image = "linuxserver/nzbget:24.3.20240920@sha256:fd7ade0a933dbcfe156863289be8c4feb10b539a8540961c0985baaa92290c72";
              imagePullPolicy = "Always";
              resources = { };
              volumeMounts = [
                {
                  name = "nzbget-config";
                  mountPath = "/config";
                }
              ];
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
                {
                  name = "NZBGET_USER";
                  valueFrom = {
                    secretKeyRef = {
                      name = "nzbget-auth";
                      key = "user";
                    };
                  };
                }
                {
                  name = "NZBGET_PASS";
                  valueFrom = {
                    secretKeyRef = {
                      name = "nzbget-auth";
                      key = "password";
                    };
                  };
                }
              ];
            }
          ];
          volumes = [
            {
              name = "nzbget-config";
              persistentVolumeClaim = {
                claimName = "nzbget-config";
              };
            }
          ];
        };
      };
    };
  };
}
