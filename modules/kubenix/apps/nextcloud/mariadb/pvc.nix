{
  kubernetes.resources.persistentVolumeClaims.nextcloud-mariadb = {
    metadata = {
      name = "nextcloud-mariadb";
      namespace = "nextcloud";
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
          storage = "30Gi";
        };
      };
    };
  };
}
