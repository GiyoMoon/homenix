{
  kubernetes.resources.persistentVolumeClaims.radarr-config = {
    metadata = {
      name = "radarr-config";
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
}
