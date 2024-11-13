{
  kubernetes.resources.persistentVolumeClaims.enclosed-data = {
    metadata = {
      name = "enclosed-data";
      namespace = "enclosed";
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
          storage = "20Gi";
        };
      };
    };
  };
}
