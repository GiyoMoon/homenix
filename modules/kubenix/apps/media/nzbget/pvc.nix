{
  kubernetes.resources.persistentVolumeClaims.nzbget-config = {
    metadata = {
      name = "nzbget-config";
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
