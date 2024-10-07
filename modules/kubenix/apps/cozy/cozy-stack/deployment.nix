{ sops, ... }:
{
  kubernetes.resources.deployments.cozy-stack = {
    metadata = {
      name = "cozy-stack";
      namespace = "cozy";
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
          app = "cozy-stack";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "cozy-stack";
          };
        };
        spec = {
          containers = [
            {
              name = "cozy-stack";
              image = "ghcr.io/giyomoon/cozy-stack:1.6.29@sha256:66c4348387f909ea71e01017110c936cd0d6a988799ea285563477148655cfef";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
                {
                  name = "COUCHDB_HOST";
                  value = "10.0.20.40";
                }
                {
                  name = "COUCHDB_PORT";
                  value = "5984";
                }
                {
                  name = "COUCHDB_USER";
                  value = "cozy";
                }
                {
                  name = "COUCHDB_PASSWORD";
                  value = "ref+file://" + sops.secrets.cozy_couchdb_password.path;
                }
                {
                  name = "COZY_COUCHDB_URL";
                  value = "ref+file://" + sops.secrets.cozy_couchdb_url.path;
                }
                {
                  name = "COZY_ADMIN_PASSPHRASE";
                  value = "ref+file://" + sops.secrets.cozy_stack_password.path;
                }
                {
                  name = "COZY_HOST";
                  value = "0.0.0.0";
                }
                {
                  name = "COZY_DOMAIN";
                  value = "cozy.jasi.app";
                }
                {
                  name = "COZY_HOST_VALIDATE";
                  value = "false";
                }
              ];
              ports = [
                {
                  protocol = "TCP";
                  containerPort = 8080;
                }
              ];
              volumeMounts = [
                {
                  name = "cozy-stack-config";
                  mountPath = "/etc/cozy";
                }
                {
                  name = "cozy-stack-data";
                  mountPath = "/var/lib/cozy";
                }
              ];
            }
          ];
          volumes = [
            {
              name = "cozy-stack-config";
              persistentVolumeClaim = {
                claimName = "cozy-stack-config";
              };
            }
            {
              name = "cozy-stack-data";
              persistentVolumeClaim = {
                claimName = "cozy-stack-data";
              };
            }
          ];
        };
      };
    };
  };
}
