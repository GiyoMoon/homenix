{ sops, ... }:
{
  kubernetes.resources.deployments.nextcloud-mariadb = {
    metadata = {
      name = "nextcloud-mariadb";
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
          app = "nextcloud-mariadb";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "nextcloud-mariadb";
          };
        };
        spec = {
          containers = [
            {
              name = "nextcloud";
              image = "mariadb:lts@sha256:7d3fd2f513cc2a5edad3a6aed2d7154ab1503ee3c3362bb54d8cb6112959b4f2";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
                {
                  name = "MARIADB_ROOT_PASSWORD";
                  value = "ref+file://" + sops.secrets.nextcloud_mariadb_password.path;
                }
              ];
              volumeMounts = [
                {
                  name = "nextcloud-mariadb";
                  mountPath = "/var/lib/mysql";
                }
              ];
            }
          ];
          volumes = [
            {
              name = "nextcloud-mariadb";
              persistentVolumeClaim = {
                claimName = "nextcloud-mariadb";
              };
            }
          ];
        };
      };
    };
  };
}
