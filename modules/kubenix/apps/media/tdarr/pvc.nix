{
  kubernetes.resources.persistentVolumeClaims = {
    tdarr-server = {
      metadata = {
        name = "tdarr-server";
        namespace = "media";
        labels = {
          "recurring-job.longhorn.io/source" = "enabled";
          "recurring-job.longhorn.io/backup" = "enabled";
        };
      };
      spec = {
        accessModes = [ "ReadWriteOnce" ];
        storageClassName = "longhorn-ssd";
        resources = {
          requests = {
            storage = "10Gi";
          };
        };
      };
    };
    tdarr-config = {
      metadata = {
        name = "tdarr-config";
        namespace = "media";
        labels = {
          "recurring-job.longhorn.io/source" = "enabled";
          "recurring-job.longhorn.io/backup" = "enabled";
        };
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
  };
}
