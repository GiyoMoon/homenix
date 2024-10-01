{
  kubernetes.resources.persistentVolumeClaims.radarr-config = {
    metadata = {
      name = "radarr-config";
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
}
