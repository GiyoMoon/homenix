{
  kubernetes.resources.deployments.cloudflare-ddns = {
    metadata = {
      name = "cloudflare-ddns";
      namespace = "ddns";
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
          app = "cloudflare-ddns";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "cloudflare-ddns";
          };
        };
        spec = {
          containers = [
            {
              name = "cloudflare-ddns";
              image = "timothyjmiller/cloudflare-ddns:latest@sha256:2187e122660d6a2d451ef7c53fd4805c133133f4f47552256352c1e2a7f49ee2";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "CONFIG_PATH";
                  value = "/etc/cloudflare-ddns/";
                }
              ];
              volumeMounts = [
                {
                  name = "cloudflare-ddns-config";
                  mountPath = "/etc/cloudflare-ddns";
                  readOnly = true;
                }
              ];
            }
          ];
          volumes = [
            {
              name = "cloudflare-ddns-config";
              secret = {
                secretName = "cloudflare-ddns-config";
              };
            }
          ];
        };
      };
    };
  };
}
