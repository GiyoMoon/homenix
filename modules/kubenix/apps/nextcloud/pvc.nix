{
  kubernetes.resources.persistentVolumeClaims = {
    nextcloud-config = {
      metadata = {
        name = "nextcloud-config";
        namespace = "nextcloud";
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
    nextcloud-data = {
      metadata = {
        name = "nextcloud-data";
        namespace = "nextcloud";
        labels = {
          "recurring-job.longhorn.io/source" = "enabled";
          "recurring-job.longhorn.io/backup" = "enabled";
        };
      };
      spec = {
        accessModes = [ "ReadWriteOnce" ];
        storageClassName = "longhorn-hdd";
        resources = {
          requests = {
            storage = "1Ti";
          };
        };
      };
    };
  };
}
