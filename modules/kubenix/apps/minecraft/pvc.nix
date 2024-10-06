{
  kubernetes.resources.persistentVolumeClaims = {
    minecraft-data = {
      metadata = {
        name = "minecraft-data";
        namespace = "minecraft";
      };
      spec = {
        accessModes = [ "ReadWriteMany" ];
        storageClassName = "longhorn-ssd";
        resources = {
          requests = {
            storage = "20Gi";
          };
        };
      };
    };
    minecraft-backup = {
      metadata = {
        name = "minecraft-backup";
        namespace = "minecraft";
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
            storage = "40Gi";
          };
        };
      };
    };
  };
}
