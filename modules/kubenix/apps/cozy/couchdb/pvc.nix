{
  kubernetes.resources.persistentVolumeClaims.cozy-couchdb-data = {
    metadata = {
      name = "couchdb-data";
      namespace = "cozy";
      # Enable if cozy is cool
      # labels = {
      #   "recurring-job.longhorn.io/source" = "enabled";
      #   "recurring-job.longhorn.io/backup" = "enabled";
      # };
    };
    spec = {
      accessModes = [ "ReadWriteOnce" ];
      storageClassName = "longhorn-ssd";
      resources = {
        requests = {
          storage = "5Gi";
        };
      };
    };
  };
}
