{
  kubernetes.resources.persistentVolumeClaims = {
    jellyfin-config = {
      metadata = {
        name = "jellyfin-config";
        namespace = "media";
      };
      spec = {
        accessModes = [ "ReadWriteOnce" ];
        volumeMode = "Filesystem";
        storageClassName = "longhorn-ssd";
        resources = {
          requests = {
            storage = "50Gi";
          };
        };
      };
    };
    jellyfin-data = {
      metadata = {
        name = "jellyfin-data";
        namespace = "media";
      };
      spec = {
        accessModes = [ "ReadWriteMany" ];
        volumeMode = "Filesystem";
        storageClassName = "longhorn-hdd";
        resources = {
          requests = {
            storage = "3Ti";
          };
        };
      };
    };
  };
}
