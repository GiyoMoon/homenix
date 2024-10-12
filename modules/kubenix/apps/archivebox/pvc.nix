{
  kubernetes.resources.persistentVolumeClaims.archivebox-data = {
    metadata = {
      name = "archivebox-data";
      namespace = "archivebox";
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
          storage = "50Gi";
        };
      };
    };
  };
}
