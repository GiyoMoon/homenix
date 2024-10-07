{
  kubernetes.resources.persistentVolumeClaims = {
    cozy-stack-config = {
      metadata = {
        name = "cozy-stack-config";
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
            storage = "1Gi";
          };
        };
      };
    };
    cozy-stack-data = {
      metadata = {
        name = "cozy-stack-data";
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
            storage = "50Gi";
          };
        };
      };
    };
  };
}
