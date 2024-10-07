{ sops, ... }:
{
  kubernetes.resources.deployments.cozy-couchdb = {
    metadata = {
      name = "couchdb";
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
          app = "couchdb";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "couchdb";
          };
        };
        spec = {
          containers = [
            {
              name = "couchdb";
              image = "couchdb:3.3.3@sha256:56d51ce22f055a3743449b9030b69a0763eb80c683e930c270847c8a6f7a29fa";
              imagePullPolicy = "Always";
              resources = { };
              env = [
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
                {
                  name = "COUCHDB_USER";
                  value = "cozy";
                }
                {
                  name = "COUCHDB_PASSWORD";
                  value = "ref+file://" + sops.secrets.cozy_couchdb_password.path;
                }
              ];
              volumeMounts = [
                {
                  name = "couchdb-data";
                  mountPath = "/opt/couchdb/data";
                }
              ];
            }
          ];
          volumes = [
            {
              name = "couchdb-data";
              persistentVolumeClaim = {
                claimName = "couchdb-data";
              };
            }
          ];
        };
      };
    };
  };
}
