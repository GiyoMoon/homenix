{
  kubernetes.resources.deployments.pihole = {
    metadata = {
      name = "pihole";
      namespace = "pihole";
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
          app = "pihole";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "pihole";
          };
        };
        spec = {
          containers = [
            {
              name = "pihole";
              image = "pihole/pihole:2024.07.0@sha256:0def896a596e8d45780b6359dbf82fc8c75ef05b97e095452e67a0a4ccc95377";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
                {
                  name = "WEBPASSWORD";
                  valueFrom = {
                    secretKeyRef = {
                      name = "pihole-auth";
                      key = "password";
                    };
                  };
                }
              ];
              volumeMounts = [
                {
                  name = "pihole";
                  mountPath = "/etc/pihole";
                }
              ];
              readinessProbe = {
                exec = {
                  command = [
                    "dig"
                    "@127.0.0.1"
                    "cloudflare.com"
                  ];
                };
                timeoutSeconds = 20;
                initialDelaySeconds = 5;
                periodSeconds = 60;
              };
              livenessProbe = {
                tcpSocket = {
                  port = 53;
                };
                initialDelaySeconds = 15;
                periodSeconds = 30;
              };
            }
          ];
          volumes = [
            {
              name = "pihole";
              persistentVolumeClaim = {
                claimName = "pihole";
              };
            }
          ];
        };
      };
    };
  };
}
