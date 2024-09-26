{
  kubernetes.resources.persistentVolumeClaims.jellyseerr-config = {
    metadata = {
      name = "jellyseerr-config";
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
}
