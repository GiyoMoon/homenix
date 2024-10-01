{
  kubernetes.resources.persistentVolumeClaims.nzbget-config = {
    metadata = {
      name = "nzbget-config";
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
}
