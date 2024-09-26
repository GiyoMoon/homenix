{
  kubernetes.resources.persistentVolumeClaims = {
    tdarr-server = {
      metadata = {
        name = "tdarr-server";
        namespace = "media";
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
    tdarr-config = {
      metadata = {
        name = "tdarr-config";
        namespace = "media";
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
  };
}
