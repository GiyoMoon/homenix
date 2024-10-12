{
  kubernetes.resources.persistentVolumeClaims = {
    # Skyfactory 4 | 2024.10.12
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
    # Stoneblock 3
    minecraft-data-stoneblock-3 = {
      metadata = {
        name = "minecraft-data-stoneblock-3";
        namespace = "minecraft";
      };
      spec = {
        accessModes = [ "ReadWriteMany" ];
        storageClassName = "longhorn-ssd";
        resources = {
          requests = {
            storage = "10Gi";
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
