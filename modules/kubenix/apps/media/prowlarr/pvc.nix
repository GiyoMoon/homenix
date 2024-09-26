{
  kubernetes.resources.persistentVolumeClaims.prowlarr-config = {
    metadata = {
      name = "prowlarr-config";
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
