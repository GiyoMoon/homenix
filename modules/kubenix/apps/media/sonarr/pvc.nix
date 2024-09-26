{
  kubernetes.resources.persistentVolumeClaims.sonarr-config = {
    metadata = {
      name = "sonarr-config";
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
